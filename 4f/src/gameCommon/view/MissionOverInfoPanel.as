package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class MissionOverInfoPanel extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      public var titleTxt1:FilterFrameText;
      
      public var titleTxt2:FilterFrameText;
      
      public var titleTxt3:FilterFrameText;
      
      public var valueTxt1:FilterFrameText;
      
      public var valueTxt2:FilterFrameText;
      
      public var valueTxt3:FilterFrameText;
      
      public function MissionOverInfoPanel(){super();}
      
      private function initView() : void{}
      
      public function dispose() : void{}
   }
}
