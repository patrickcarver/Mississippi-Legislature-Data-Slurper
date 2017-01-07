defmodule MsLegisTest do
  use ExUnit.Case
  doctest MsLegis

  test "no change in list xml metadata" do
    metadata = %MsLegis.XmlMetadata{}
    list_xml_metadata = ~s(<?xml version="1.0" encoding="ISO-8859-1"?><?xml-stylesheet type="text/xsl" href="dtds_xslts/memberlist.xslt"?> <!DOCTYPE LEGISLATURE SYSTEM "dtds_xslts/memberlist.dtd">)
    assert list_xml_metadata == metadata.list
  end

  test "no change in member xml metadata" do
    metadata = %MsLegis.XmlMetadata{}
    member_xml_metadata = ~s(<?xml version="1.0" encoding="ISO-8859-1"?><?xml-stylesheet type="text/xsl" href="../dtds_xslts/house.xslt"?><!DOCTYPE MEMBINFO SYSTEM "../dtds_xslts/membinfo.dtd">)
    assert member_xml_metadata == metadata.member
  end
end
