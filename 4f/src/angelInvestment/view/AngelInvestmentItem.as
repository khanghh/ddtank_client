package angelInvestment.view
{
   import angelInvestment.data.AngelInvestmentItemData;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AngelInvestmentItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _priceBg:Bitmap;
      
      private var _info:AngelInvestmentItemData;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _number:NumberImage;
      
      private var _dayText:FilterFrameText;
      
      private var _tips:Component;
      
      private var _cell:BagCell;
      
      public function AngelInvestmentItem(param1:AngelInvestmentItemData){super();}
      
      private function init() : void{}
      
      public function updateInfo(param1:int, param2:Boolean) : void{}
      
      private function __onBuy(param1:MouseEvent) : void{}
      
      private function __onBuyResponse(param1:FrameEvent) : void{}
      
      private function __onGet(param1:MouseEvent) : void{}
      
      public function get canGetGoods() : Boolean{return false;}
      
      public function get canBuyGoods() : Boolean{return false;}
      
      public function dispose() : void{}
   }
}
