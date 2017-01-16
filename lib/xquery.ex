defmodule MsLegis.XQuery do
  @chair_link   "//CHAIR_LINK/text()"
  @protemp_link "//PROTEMP_LINK/text()"
  @m1_links     "//MEMBER/M1_LINK/text()"
  @m2_links     "//MEMBER/M2_LINK/text()"
  @m3_links     "//MEMBER/M3_LINK/text()"
  @m4_links     "//MEMBER/M4_LINK/text()"
  @m5_links     "//MEMBER/M5_LINK/text()"

  def chair_link, do: @chair_link
  def protemp_link, do: @protemp_link
  def m1_links, do: @m1_links
  def m2_links, do: @m2_links
  def m3_links, do: @m3_links
  def m4_links, do: @m4_links
  def m5_links, do: @m5_links
end
