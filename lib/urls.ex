defmodule MsLegis.Urls do
   @base "http://billstatus.ls.state.ms.us/members/"
   @house "hr_membs.xml"
   @senate ""

   def house_link, do: @base <> @house
   def senate_link, do: @base <> @senate
   def base_link, do: @base
end
