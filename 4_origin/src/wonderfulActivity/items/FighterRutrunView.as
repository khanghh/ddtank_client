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
      
      public function FighterRutrunView(param1:ActivityTypeData)
      {
         super();
         _data = param1;
      }
      
      public function setState(param1:int, param2:int) : void
      {
      }
      
      private function initTimer() : void
      {
         startData = _data.StartTime;
         endData = _data.EndTime;
         fightTimerHander();
         WonderfulActivityManager.Instance.addTimerFun("fighter",fightTimerHander);
      }
      
      private function fightTimerHander() : void
      {
         nowdate = TimeManager.Instance.Now();
         var _loc1_:String = WonderfulActivityManager.Instance.getTimeDiff(endData,nowdate);
         _timerTxt.text = _loc1_;
         if(_loc1_ == "0")
         {
            dispose();
            WonderfulActivityManager.Instance.delTimerFun("fighter");
            SocketManager.Instance.out.sendWonderfulActivity(0,-1);
            WonderfulActivityManager.Instance.currView = "-1";
         }
      }
      
      public function init() : void
      {
         _tittle = ComponentFactory.Instance.creat("wonderfulactivity.rechargeTille3");
         addChild(_tittle);
         _goldLine = ComponentFactory.Instance.creat("wonderfulactivity.libao.goldLine");
         addChild(_goldLine);
         _downBack = ComponentFactory.Instance.creat("wonderfulactivity.scale9cornerImageTree");
         _downBack.width = 476;
         _downBack.height = 340;
         _downBack.x = 253;
         _downBack.y = 111;
         addChild(_downBack);
         _back = ComponentFactory.Instance.creat("wonderfulactivity.fighter.back");
         addChild(_back);
         _treeImage2 = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.rightBottomBgImg");
         addChild(_treeImage2);
         _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.gotoRechargeBtn");
         addChild(_btn);
         _goldStone = ComponentFactory.Instance.creat("wonderfulactivity.libao.gold");
         addChild(_goldStone);
         _timerTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.farmetimeTxt");
         _timerTxt.x = 374;
         _timerTxt.y = 260;
         addChild(_timerTxt);
         _goodsContents = new Sprite();
         addChild(_goodsContents);
         _goodsContents.x = 282;
         _goodsContents.y = 369;
         initGoods();
         initTimer();
      }
      
      private function initGoods() : void
      {
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc4_:Vector.<RechargeData> = FirstRechargeManger.Instance.getGoodsList();
         var _loc5_:int = _loc4_.length;
         var _loc1_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            if(_loc1_ >= 5)
            {
               return;
            }
            if(_loc4_[_loc7_].RewardID > 2000 && _loc4_[_loc7_].RewardID < 3000)
            {
               _loc2_ = new BagCell(_loc7_);
               _loc6_ = new InventoryItemInfo();
               _loc6_.TemplateID = _loc4_[_loc7_].RewardItemID;
               _loc6_ = ItemManager.fill(_loc6_);
               _loc6_.IsBinds = _loc4_[_loc7_].IsBind;
               _loc6_.ValidDate = _loc4_[_loc7_].RewardItemValid;
               _loc6_.StrengthenLevel = _loc4_[_loc7_].StrengthenLevel;
               _loc6_.AttackCompose = _loc4_[_loc7_].AttackCompose;
               _loc6_.DefendCompose = _loc4_[_loc7_].DefendCompose;
               _loc6_.AgilityCompose = _loc4_[_loc7_].AgilityCompose;
               _loc6_.LuckCompose = _loc4_[_loc7_].LuckCompose;
               _loc2_.info = _loc6_;
               _loc3_ = ComponentFactory.Instance.creat("wonderfulactivity.goods.back");
               addChild(_loc3_);
               _loc3_.x = (_loc3_.width + 5) * _loc1_;
               _loc2_.x = _loc3_.width / 2 - _loc2_.width / 2 + _loc3_.x + 1;
               _loc2_.y = _loc3_.height / 2 - _loc2_.height / 2 + 1;
               _loc2_.setBgVisible(false);
               _loc2_.setCount(_loc4_[_loc7_].RewardItemCount);
               _goodsContents.addChild(_loc3_);
               _goodsContents.addChild(_loc2_);
               _loc1_++;
            }
            _loc7_++;
         }
      }
      
      public function dispose() : void
      {
         WonderfulActivityManager.Instance.delTimerFun("fighter");
         while(_goodsContents.numChildren)
         {
            ObjectUtils.disposeObject(_goodsContents.getChildAt(0));
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
      
      public function content() : Sprite
      {
         return this;
      }
   }
}
