defmodule MsLegis do
  @moduledoc """
  Processes member roster xml from MS Legislature
  """

  import SweetXml
  alias MsLegis.{CleanXml, GetXmlFromUrl, GetXQueryResult, Urls, XmlMetadata, XQuery}

  @doc """
  Main function
  """
  def run do
    IO.puts "--- Started ---"

    GetXmlFromUrl.apply(Urls.house_link)
    |> get_list_xml(XmlMetadata.list)
    |> process_list(Urls.base_link, XmlMetadata.member)

    IO.puts "--- Finished ---"
  end

  @doc """
  Gets xml from each member xml page and processes data
  """
  def process_list(list, base_url, metadata) do
    for link <- list do
      GetXmlFromUrl.apply(base_url <> link)
      |> process_member_xml(metadata)
    end
  end

  @doc """
  Removes xml metadata and returns string list of member xml pages
  """
  def get_list_xml(body, metadata) do
    body
    |> CleanXml.apply(metadata)
    |> create_list
  end

  @doc """
  Parses xml from member xml page
  """
  def process_member_xml(body, metadata) do
    xml = body
          |> CleanXml.remove_bad_quotes
          |> CleanXml.apply(metadata)

    district =    xml |> SweetXml.xpath(~x"//DISTRICT/text()"s)
    name =        xml |> SweetXml.xpath(~x"//DISP_NAME/text()"s)
    thumbnail =   xml |> SweetXml.xpath(~x"//IMG_NAME/text()"s)
    party =       xml |> SweetXml.xpath(~x"//PARTY/text()"s)
    email =       xml |> SweetXml.xpath(~x"//EMAIL_ADDRESS/text()"s)

    IO.puts "#{district} | #{name} | #{party}"
  end

  @doc """
  Returns string list of member xml pages
  """
  def create_list(xml) do
    chair_link =   xml |> GetXQueryResult.get_text(XQuery.chair_link)
    protemp_link = xml |> GetXQueryResult.get_text(XQuery.protemp_link)

    officer_links = [chair_link, protemp_link]

    m1_links = xml |> GetXQueryResult.get_list(XQuery.m1_links)
    m2_links = xml |> GetXQueryResult.get_list(XQuery.m2_links)
    m3_links = xml |> GetXQueryResult.get_list(XQuery.m3_links)
    m4_links = xml |> GetXQueryResult.get_list(XQuery.m4_links)
    m5_links = xml |> GetXQueryResult.get_list(XQuery.m5_links)

    officer_links ++ m1_links ++ m2_links ++ m3_links ++ m4_links ++ m5_links
  end
end
