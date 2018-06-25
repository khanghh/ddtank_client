package starling.utils
{
   public function formatString(format:String, ... args) : String
   {
      var i:int = 0;
      for(i = 0; i < args.length; )
      {
         format = format.replace(new RegExp("\\{" + i + "\\}","g"),args[i]);
         i++;
      }
      return format;
   }
}
