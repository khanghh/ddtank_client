package consortion.view.boss
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConsortiaBossLevelCell extends Sprite implements Disposeable
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _light:Bitmap;
      
      private var _level:int;
      
      public function ConsortiaBossLevelCell(param1:int){super();}
      
      public function judgeMaxLevel(param1:int) : void{}
      
      public function update(param1:String) : void{}
      
      public function changeLightSizePos(param1:int, param2:int, param3:int, param4:int) : void{}
      
      public function get level() : int{return 0;}
      
      private function overHandler(param1:MouseEvent) : void{}
      
      private function outHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
