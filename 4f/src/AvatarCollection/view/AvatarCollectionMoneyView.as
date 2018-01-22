package AvatarCollection.view
{
   import bagAndInfo.bag.RichesButton;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class AvatarCollectionMoneyView extends Sprite implements Disposeable
   {
       
      
      private var _honorBg:MovieClip;
      
      private var _honorTxt:FilterFrameText;
      
      private var _goldBg:MovieClip;
      
      private var _goldTxt:FilterFrameText;
      
      private var _honorButton:RichesButton;
      
      private var _goldButton:RichesButton;
      
      public function AvatarCollectionMoneyView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function refreshView() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
