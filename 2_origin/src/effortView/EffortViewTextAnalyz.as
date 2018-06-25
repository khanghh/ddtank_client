package effortView
{
   public class EffortViewTextAnalyz
   {
       
      
      public function EffortViewTextAnalyz()
      {
         super();
      }
      
      public static function start(str:String) : String
      {
         var i:int = 0;
         var newstr:* = str;
         var regArr:Array = new Array(/cr>|cg>|cb>/gi,/<cr/gi,/<cg/gi,/<cb/gi,/【/gi,/】/gi);
         var strArr:Array = new Array("</font><font>","</font><font COLOR=\'#FF0000\'>","</font><font COLOR=\'#00FF00\'>","</font><font COLOR=\'#0000FF\'>","</font><a href=\'http://blog.163.com/redirect.html\'><font COLOR=\'#00FF00\'><u>","</u></font></a><font>");
         for(i = 0; i < regArr.length; )
         {
            newstr = newstr.replace(regArr[i],strArr[i]);
            i++;
         }
         return "<font>" + newstr + "</font>";
      }
   }
}
