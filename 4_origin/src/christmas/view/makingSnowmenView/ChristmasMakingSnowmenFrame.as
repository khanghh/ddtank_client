package christmas.view.makingSnowmenView
{
   import bagAndInfo.cell.BagCell;
   import christmas.ChristmasCoreController;
   import christmas.ChristmasCoreManager;
   import christmas.event.ChristmasRoomEvent;
   import christmas.info.ChristmasSystemItemsInfo;
   import christmas.items.ExpBar;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import org.aswing.KeyboardManager;
   
   public class ChristmasMakingSnowmenFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _bagitem:BagCell;
      
      private var _selfInfo:SelfInfo;
      
      private var _completeText:FilterFrameText;
      
      private var _expBar:ExpBar;
      
      private var _addSnowBnt:BaseButton;
      
      private var _addCountText:FilterFrameText;
      
      private var _activeTimeTxt:FilterFrameText;
      
      private var _conditionTxt:FilterFrameText;
      
      private var _rewardTxt:FilterFrameText;
      
      private var _mSnoRight:ChristmasMakingSnowmenRightFrame;
      
      private var _christmasSnowmenView:ChristmasSnowmenView;
      
      public function ChristmasMakingSnowmenFrame()
      {
         _selfInfo = PlayerManager.Instance.Self;
         super();
         initView();
         initEvent();
         initText();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("christmas.makingSnowmenTiTle");
         _bg = ComponentFactory.Instance.creatBitmap("asset.christmas.makingSnowmenImg");
         _mSnoRight = ComponentFactory.Instance.creatCustomObject("christmas.makingSnowmen.mSnoRightFrame");
         _completeText = ComponentFactory.Instance.creatComponentByStylename("christmas.makingSnowmen.completeTxt");
         _addSnowBnt = ComponentFactory.Instance.creatComponentByStylename("christmas.makingSnowmen.addSnowBnt");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("christmas.makingSnowmen.expBar");
         _addCountText = ComponentFactory.Instance.creatComponentByStylename("christmas.makingSnowmen.addCountText");
         _activeTimeTxt = ComponentFactory.Instance.creatComponentByStylename("christmas.makingSnowmen.activeTimeTxt");
         _conditionTxt = ComponentFactory.Instance.creatComponentByStylename("christmas.makingSnowmen.conditionTxt");
         _rewardTxt = ComponentFactory.Instance.creatComponentByStylename("christmas.makingSnowmen.rewardTxt");
         _christmasSnowmenView = ComponentFactory.Instance.creatCustomObject("christmas.Snowmen.view");
         addToContent(_bg);
         addToContent(_completeText);
         addToContent(_expBar);
         addToContent(_addSnowBnt);
         addToContent(_addCountText);
         addToContent(_activeTimeTxt);
         addToContent(_conditionTxt);
         addToContent(_rewardTxt);
         addToContent(_christmasSnowmenView);
         addToContent(_mSnoRight);
         goodsCell();
      }
      
      public function get expBar() : ExpBar
      {
         return _expBar;
      }
      
      private function initText() : void
      {
         _completeText.text = LanguageMgr.GetTranslation("christmas.makingSnowmen.completeTxt.LG");
         _addCountText.text = ChristmasCoreController.instance.model.count + "";
         _activeTimeTxt.text = ChristmasCoreController.instance.model.activityTime;
         _conditionTxt.text = LanguageMgr.GetTranslation("christmas.makingSnowmen.conditionTxt.LG");
         _rewardTxt.text = LanguageMgr.GetTranslation("christmas.makingSnowmen.rewardTxt.LG");
      }
      
      private function goodsCell() : void
      {
         var christmasInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(201144);
         _bagitem = new BagCell(0,christmasInfo);
         _bagitem.x = 30;
         _bagitem.y = 389;
         var _loc2_:int = 41;
         _bagitem.height = _loc2_;
         _bagitem.width = _loc2_;
         addToContent(_bagitem);
         upDatafitCount();
      }
      
      protected function updateCount(event:BagEvent) : void
      {
         upDatafitCount();
      }
      
      public function upDatafitCount() : void
      {
         if(!_bagitem)
         {
            return;
         }
         var bagInfo:BagInfo = _selfInfo.getBag(1);
         var conut:int = bagInfo.getItemCountByTemplateId(201144);
         _bagitem.setCount(conut);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _addSnowBnt.addEventListener("click",__onClickAddSnowHander);
         ChristmasCoreManager.instance.addEventListener("score_convert",__scoreConvertEventHandler);
         _selfInfo.PropBag.addEventListener("update",__updateBag);
      }
      
      protected function __updateBag(event:BagEvent) : void
      {
         var info:* = null;
         var bag:BagInfo = event.target as BagInfo;
         var changes:Dictionary = event.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = changes;
         for each(var i in changes)
         {
            info = bag.getItemAt(i.Place);
            if(info && info.TemplateID == 201144)
            {
               _bagitem.setCount(bag.getItemCountByTemplateId(201144));
            }
         }
      }
      
      private function __onClickAddSnowHander(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ChristmasCoreController.instance.showTransactionFrame("",showIsBuyFrame,null,this,true,true);
      }
      
      private function showIsBuyFrame(num:int = 1) : void
      {
         if(num <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("christmas.curInfo.notfitNum"));
            return;
         }
         if(ChristmasCoreController.instance.getCount() <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("christmas.curInfo.notfit"));
            return;
         }
         sendBuyToSnowPackDouble(num);
      }
      
      private function sendBuyToSnowPackDouble(num:int = 1) : void
      {
         var isDouble:Boolean = ChristmasCoreManager.instance.model.isSelect;
         if(isDouble)
         {
            if(!ChristmasCoreManager.instance.checkMoney(num * ChristmasCoreManager.instance.model.money))
            {
               SocketManager.Instance.out.sendChristmasUpGrade(num,isDouble);
               KeyboardManager.getInstance().isStopDispatching = true;
               SoundManager.instance.play("170");
            }
            ChristmasCoreManager.instance.model.isSelect = false;
            return;
         }
         SocketManager.Instance.out.sendChristmasUpGrade(num,isDouble);
         KeyboardManager.getInstance().isStopDispatching = true;
         SoundManager.instance.play("170");
      }
      
      private function __scoreConvertEventHandler(event:ChristmasRoomEvent) : void
      {
         var i:int = 0;
         var poorNum:int = 0;
         _addCountText.text = ChristmasCoreManager.instance.model.count + "";
         if(_mSnoRight.shopItemArr == null)
         {
            return;
         }
         i = 0;
         while(i < ChristmasCoreManager.instance.model.packsLen - 1)
         {
            if(ChristmasCoreManager.instance.CanGetGift(i) && ChristmasCoreManager.instance.model.count >= _mSnoRight.shopItemArr[i].snowPackNum)
            {
               _mSnoRight.shopItemArr[i].specialButton();
            }
            i++;
         }
         if(ChristmasCoreManager.instance.model.lastPacks > ChristmasCoreManager.instance.model.count)
         {
            _mSnoRight.shopItemArr[ChristmasCoreManager.instance.model.packsLen - 1].grayButton();
         }
         else
         {
            _mSnoRight.shopItemArr[ChristmasCoreManager.instance.model.packsLen - 1].specialButton();
            if(ChristmasCoreManager.instance.model.count - ChristmasCoreManager.instance.model.snowPackNum[ChristmasCoreManager.instance.model.packsLen - 2] >= ChristmasCoreManager.instance.model.snowPackNum[ChristmasCoreManager.instance.model.packsLen - 1] * (ChristmasCoreManager.instance.model.packsNumber + 1))
            {
               _mSnoRight.shopItemArr[ChristmasCoreManager.instance.model.packsLen - 1]._poorTxt.text = LanguageMgr.GetTranslation("christmas.poortTxt.OK.LG");
            }
            else
            {
               poorNum = ChristmasCoreManager.instance.model.snowPackNum[ChristmasCoreManager.instance.model.packsLen - 1] - (ChristmasCoreManager.instance.model.count - (ChristmasCoreManager.instance.model.snowPackNum[ChristmasCoreManager.instance.model.packsLen - 2] + ChristmasCoreManager.instance.model.snowPackNum[ChristmasCoreManager.instance.model.packsLen - 1] * ChristmasCoreManager.instance.model.packsNumber));
               _mSnoRight.shopItemArr[ChristmasCoreManager.instance.model.packsLen - 1]._poorTxt.text = LanguageMgr.GetTranslation("christmas.list.poorTxt.LG",poorNum);
            }
         }
      }
      
      public function snowmenAction(info:ChristmasSystemItemsInfo) : void
      {
         _christmasSnowmenView.upGradeAction(info);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_addSnowBnt)
         {
            _addSnowBnt.removeEventListener("click",__onClickAddSnowHander);
         }
         PlayerManager.Instance.removeEventListener("gemstone_buy_count",updateCount);
         ChristmasCoreManager.instance.removeEventListener("score_convert",__scoreConvertEventHandler);
         _selfInfo.PropBag.removeEventListener("update",__updateBag);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ChristmasCoreController.instance.model.isSelect = false;
         ObjectUtils.disposeObject(_bagitem);
         _bagitem = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(_expBar)
         {
            ObjectUtils.disposeObject(_expBar);
         }
         _expBar = null;
         if(_christmasSnowmenView)
         {
            ObjectUtils.disposeObject(_christmasSnowmenView);
         }
         _christmasSnowmenView = null;
         if(_mSnoRight)
         {
            ObjectUtils.disposeObject(_mSnoRight);
         }
         _mSnoRight = null;
      }
   }
}
