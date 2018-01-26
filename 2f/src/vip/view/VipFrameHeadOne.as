package vip.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class VipFrameHeadOne extends Sprite implements Disposeable
   {
       
      
      private var _topBG:ScaleBitmapImage;
      
      private var _buyPackageBtn:BaseButton;
      
      private var _dueDataWord:FilterFrameText;
      
      private var _dueData:FilterFrameText;
      
      private var _buyPackageTxt:FilterFrameText;
      
      private var _buyPackageTxt1:FilterFrameText;
      
      private var _price:int = 6680;
      
      public function VipFrameHeadOne(){super();}
      
      private function _init() : void{}
      
      private function addEvent() : void{}
      
      private function __onBuyClick(param1:MouseEvent) : void{}
      
      private function _responseI(param1:FrameEvent) : void{}
      
      private function dobuy() : void{}
      
      private function removeEvent() : void{}
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void{}
      
      private function upView() : void{}
      
      public function dispose() : void{}
   }
}
