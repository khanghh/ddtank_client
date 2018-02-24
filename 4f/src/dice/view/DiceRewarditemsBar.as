package dice.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import dice.controller.DiceController;
   import dice.event.DiceEvent;
   import flash.display.Sprite;
   
   public class DiceRewarditemsBar extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _caption:FilterFrameText;
      
      private var _line:ScaleBitmapImage;
      
      private var _titleBG:MutipleImage;
      
      private var _listPanel:ScrollPanel;
      
      private var _list:VBox;
      
      private var _tempStr:String;
      
      public function DiceRewarditemsBar(){super();}
      
      private function preInitialize() : void{}
      
      private function initialize() : void{}
      
      private function addEvent() : void{}
      
      private function __onAddRewardItem(param1:DiceEvent) : void{}
      
      private function __onPlayerStateChanged(param1:DiceEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
