package welfareCenter.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.InviteManager;
   import welfareCenter.WelfareCenterManager;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   import welfareCenter.callBackLotteryDraw.view.CallBackLotteryDrawFrame;
   import welfareCenter.icon.WelfareCenterItem;
   import welfareCenter.icon.WelfareCenterItemTime;
   
   public class WelfareCenterFrame extends Frame
   {
       
      
      private var _currentType:int = -1;
      
      private var _bg:ScaleBitmapImage;
      
      private var _content:Sprite;
      
      private var _itemList:Vector.<WelfareCenterItem>;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _vBox:VBox;
      
      private var _backFundView:CallBackFundView;
      
      private var _backLotteryView:CallBackLotteryDrawFrame;
      
      private var _gradeGiftView:OldPlayerGradeGiftView;
      
      public function WelfareCenterFrame(){super();}
      
      public function show() : void{}
      
      override protected function onFrameClose() : void{}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      private function initItem() : void{}
      
      public function updateView(param1:int) : void{}
      
      protected function onOpenView(param1:Event) : void{}
      
      private function onZeroFresh(param1:Event) : void{}
      
      private function __onClickItem(param1:MouseEvent) : void{}
      
      private function __onCheckItemShine(param1:Event = null) : void{}
      
      override public function dispose() : void{}
   }
}
