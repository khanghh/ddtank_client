package panicBuying.components
{
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Shape;
   
   public class DeleteLineUtil
   {
       
      
      public function DeleteLineUtil()
      {
         super();
      }
      
      public static function newDeleteLine(fft:FilterFrameText) : Shape
      {
         var line:Shape = new Shape();
         line.graphics.lineStyle(1,fft.textColor,1);
         line.graphics.moveTo(0,fft.height / 2);
         line.graphics.lineTo(fft.width,fft.height / 2);
         line.graphics.endFill();
         line.x = fft.x;
         line.y = fft.y;
         return line;
      }
      
      public static function setDeleteLine(line:Shape, fft:FilterFrameText) : void
      {
         line.graphics.clear();
         line.graphics.lineStyle(1,fft.textColor,1);
         line.graphics.moveTo(0,fft.height / 2);
         line.graphics.lineTo(fft.width,fft.height / 2);
         line.graphics.endFill();
         line.x = fft.x;
         line.y = fft.y;
      }
   }
}
