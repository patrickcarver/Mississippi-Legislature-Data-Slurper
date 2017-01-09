defmodule MsLegis do
  import SweetXml

  defmodule XmlMetadata do
    defstruct list:   ~s(<?xml version="1.0" encoding="ISO-8859-1"?><?xml-stylesheet type="text/xsl" href="dtds_xslts/memberlist.xslt"?> <!DOCTYPE LEGISLATURE SYSTEM "dtds_xslts/memberlist.dtd">),
              member: ~s(<?xml version="1.0" encoding="ISO-8859-1"?><?xml-stylesheet type="text/xsl" href="../dtds_xslts/house.xslt"?><!DOCTYPE MEMBINFO SYSTEM "../dtds_xslts/membinfo.dtd">)
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
  end

  def run do
    IO.puts "--- Started ---"

    xml_metadata = %XmlMetadata{}

    base_url = "http://billstatus.ls.state.ms.us/members/"
    house_url = base_url <> "hr_membs.xml"

    response = HTTPotion.get house_url
    links_list = response.body |> get_list_xml(xml_metadata.list)

    process_list(links_list, base_url, xml_metadata.member)

    IO.puts "--- Finished ---"
  end

  def process_list(list, base_url, metadata) do
    for link <- list do
      member_link = base_url <> link
      response = HTTPotion.get member_link
      IO.puts process_member_xml(response.body, metadata)
    end
  end

  def get_list_xml(body, metadata) do
    body
    |> CleanXml.apply(metadata)
    |> create_list
  end

  def process_member_xml(body, metadata) do
    body
    |> CleanXml.apply(metadata)
    |> xpath(~x"//PARTY/text()"s)
  end



  def create_list(xml) do
    chair_link = xml |> xpath(~x"//CHAIR_LINK/text()"s)
    protemp_link = xml |> xpath(~x"//PROTEMP_LINK/text()"s)

    officer_links = [chair_link, protemp_link]

    m1_links = xml |> xpath(~x"//MEMBER/M1_LINK/text()"l) |> Enum.map(fn(x) -> List.to_string(x) end)
    m2_links = xml |> xpath(~x"//MEMBER/M2_LINK/text()"l) |> Enum.map(fn(x) -> List.to_string(x) end)
    m3_links = xml |> xpath(~x"//MEMBER/M3_LINK/text()"l) |> Enum.map(fn(x) -> List.to_string(x) end)
    m4_links = xml |> xpath(~x"//MEMBER/M4_LINK/text()"l) |> Enum.map(fn(x) -> List.to_string(x) end)
    m5_links = xml |> xpath(~x"//MEMBER/M5_LINK/text()"l) |> Enum.map(fn(x) -> List.to_string(x) end)

    officer_links ++ m1_links ++ m2_links ++ m3_links ++ m4_links ++ m5_links
  end
end
