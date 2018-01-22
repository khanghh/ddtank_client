package wonderfulActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.ActivityTypeData;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import firstRecharge.FirstRechargeManger;
   import firstRecharge.data.RechargeData;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.views.IRightView;
   
   public class FighterRutrunView extends Sprite implements IRightView
   {
       
      
      private var _tittle:Bitmap;
      
      private var _goldLine:Bitmap;
      
      private var _back:Bitmap;
      
      private var _goldStone:Bitmap;
      
      private var _btn:SimpleBitmapButton;
      
      private var _treeImage2:ScaleBitmapImage;
      
      private var _data:ActivityTypeData;
      
      private var _goodsContents:Sprite;
      
      private var _timerTxt:FilterFrameText;
      
      private var startData:Date;
      
      private var endData:Date;
      
      private var nowdate:Date;
      
      private var _downBack:ScaleBitmapImage;
      
      public function FighterRutrunView(param1:ActivityTypeData){super();}
      
      public function setState(param1:int, param2:int) : void{}
      
      private function initTimer() : void{}
      
      private function fightTimerHander() : void{}
      
      public function init() : void{}
      
      private function initGoods() : void{}
      
      public function dispose() : void{}
      
      public function content() : Sprite{return null;}
   }
}
