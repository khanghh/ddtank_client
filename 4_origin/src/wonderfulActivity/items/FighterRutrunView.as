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
      
      public function FighterRutrunView(data:ActivityTypeData)
      {
         super();
         _data = data;
      }
      
      public function setState(type:int, id:int) : void
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
         var str:String = WonderfulActivityManager.Instance.getTimeDiff(endData,nowdate);
         _timerTxt.text = str;
         if(str == "0")
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
         var i:int = 0;
         var cell:* = null;
         var info:* = null;
         var back:* = null;
         var list:Vector.<RechargeData> = FirstRechargeManger.Instance.getGoodsList();
         var len:int = list.length;
         var count:int = 0;
         for(i = 0; i < len; )
         {
            if(count >= 5)
            {
               return;
            }
            if(list[i].RewardID > 2000 && list[i].RewardID < 3000)
            {
               cell = new BagCell(i);
               info = new InventoryItemInfo();
               info.TemplateID = list[i].RewardItemID;
               info = ItemManager.fill(info);
               info.IsBinds = list[i].IsBind;
               info.ValidDate = list[i].RewardItemValid;
               info.StrengthenLevel = list[i].StrengthenLevel;
               info.AttackCompose = list[i].AttackCompose;
               info.DefendCompose = list[i].DefendCompose;
               info.AgilityCompose = list[i].AgilityCompose;
               info.LuckCompose = list[i].LuckCompose;
               cell.info = info;
               back = ComponentFactory.Instance.creat("wonderfulactivity.goods.back");
               addChild(back);
               back.x = (back.width + 5) * count;
               cell.x = back.width / 2 - cell.width / 2 + back.x + 1;
               cell.y = back.height / 2 - cell.height / 2 + 1;
               cell.setBgVisible(false);
               cell.setCount(list[i].RewardItemCount);
               _goodsContents.addChild(back);
               _goodsContents.addChild(cell);
               count++;
            }
            i++;
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
