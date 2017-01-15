defmodule MsLegis do
  import SweetXml

  defmodule XmlMetadata do
    defstruct list:   ~s(<?xml version="1.0" encoding="ISO-8859-1"?><?xml-stylesheet type="text/xsl" href="dtds_xslts/memberlist.xslt"?> <!DOCTYPE LEGISLATURE SYSTEM "dtds_xslts/memberlist.dtd">),
              member: ~s(<?xml version="1.0" encoding="ISO-8859-1"?><?xml-stylesheet type="text/xsl" href="../dtds_xslts/house.xslt"?><!DOCTYPE MEMBINFO SYSTEM "../dtds_xslts/membinfo.dtd">)
  end

  defmodule XQuery do
    defstruct chair_link:    "//CHAIR_LINK/text()",
              protemp_link:  "//PROTEMP_LINK/text()",
              m1_links:      "//MEMBER/M1_LINK/text()",
              m2_links:      "//MEMBER/M2_LINK/text()",
              m3_links:      "//MEMBER/M3_LINK/text()",
              m4_links:      "//MEMBER/M4_LINK/text()",
              m5_links:      "//MEMBER/M5_LINK/text()"
  end

  defmodule CleanXml do
    def apply(text, metadata) do
      text
      |> remove_whitespace
      |> String.replace(metadata, "")
    end

    def remove_whitespace(text) do
      text
      |> String.replace("\r", "")
      |> String.replace("\n", "")
      |> String.replace("\t", "")
    end

    def remove_bad_quotes(text) do
      text
      |> String.replace(<<147>>, "")
      |> String.replace(<<148>>, "")
    end
  end

  defmodule GetXQueryResult do
    import SweetXml

    def get_text(xml, query) do
      xml |> xpath(sigil_x(query, 's'))
    end

    def get_list(xml, query) do
      xml |> xpath(sigil_x(query, 'sl'))
    end
  end

  defmodule GetXmlFromUrl do
    def apply(url) do
      response = HTTPotion.get(url)
      response.body
    end
  end

  defmodule Urls do
     @base "http://billstatus.ls.state.ms.us/members/"
     @house "hr_membs.xml"
     @senate ""

     def house_link do
       @base <> @house
     end

     def senate_link do
       @base <> @senate
     end

     def base_link do
       @base
     end
  end

  def run do
    IO.puts "--- Started ---"

    xml_metadata = %XmlMetadata{}

    GetXmlFromUrl.apply(Urls.house_link)
    |> get_list_xml(xml_metadata.list)
    |> process_list(Urls.base_link, xml_metadata.member)

    IO.puts "--- Finished ---"
  end

  def process_list(list, base_url, metadata) do
    for link <- list do
      GetXmlFromUrl.apply(base_url <> link)
      |> process_member_xml(metadata)
    end
  end

  def get_list_xml(body, metadata) do
    body
    |> CleanXml.apply(metadata)
    |> create_list
  end

  def process_member_xml(body, metadata) do
    xml = body
          |> CleanXml.remove_bad_quotes
          |> CleanXml.apply(metadata)

    district =    xml |> SweetXml.xpath(~x"//DISTRICT/text()"s)
    name =        xml |> SweetXml.xpath(~x"//DISP_NAME/text()"s)
    thumbnail =   xml |> SweetXml.xpath(~x"//IMG_NAME/text()"s)
    party =       xml |> SweetXml.xpath(~x"//PARTY/text()"s)
    email =       xml |> SweetXml.xpath(~x"//EMAIL_ADDRESS/text()"s)
  end

  def create_list(xml) do
    xquery = %XQuery{}

    chair_link =   xml |> GetXQueryResult.get_text(xquery.chair_link)
    protemp_link = xml |> GetXQueryResult.get_text(xquery.protemp_link)

    officer_links = [chair_link, protemp_link]

    m1_links = xml |> GetXQueryResult.get_list(xquery.m1_links)
    m2_links = xml |> GetXQueryResult.get_list(xquery.m2_links)
    m3_links = xml |> GetXQueryResult.get_list(xquery.m3_links)
    m4_links = xml |> GetXQueryResult.get_list(xquery.m4_links)
    m5_links = xml |> GetXQueryResult.get_list(xquery.m5_links)

    officer_links ++ m1_links ++ m2_links ++ m3_links ++ m4_links ++ m5_links
  end
end
