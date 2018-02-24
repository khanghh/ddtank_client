package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaAssetLevelOffer;
   import ddt.events.BagEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsortionShopFrame extends Frame
   {
       
      
      private var _bg:MutipleImage;
      
      private var _scrollbg:ScaleBitmapImage;
      
      private var _bg2:MutipleImage;
      
      private var _bg3:MutipleImage;
      
      private var _gold:FilterFrameText;
      
      private var _money:FilterFrameText;
      
      private var _exploitText:FilterFrameText;
      
      private var _contributionText:FilterFrameText;
      
      private var _offer:FilterFrameText;
      
      private var _ttoffer:FilterFrameText;
      
      private var _level1:SelectedTextButton;
      
      private var _level2:SelectedTextButton;
      
      private var _level3:SelectedTextButton;
      
      private var _level4:SelectedTextButton;
      
      private var _level5:SelectedTextButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _list:ConsortionShopList;
      
      private var _word:FilterFrameText;
      
      public function ConsortionShopFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      protected function __useChangeHandler(param1:Event) : void{}
      
      private function __onUpdateBag(param1:BagEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __propChangeHandler(param1:PlayerPropertyEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function __groupChange(param1:Event) : void{}
      
      private function showLevel(param1:int) : void{}
      
      private function __managerClickHandler(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
