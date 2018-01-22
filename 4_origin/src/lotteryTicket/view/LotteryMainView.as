package lotteryTicket.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.HelperHelpBtnCreate;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import lotteryTicket.LotteryManager;
   import lotteryTicket.data.LotteryRewardInfo;
   import lotteryTicket.data.LotteryTicketInfo;
   import lotteryTicket.event.LotteryTicketEvent;
   
   public class LotteryMainView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _prizeMoney:Sprite;
      
      private var _activityTimeTxt:FilterFrameText;
      
      private var _openTimeTxt:FilterFrameText;
      
      private var _randomBtn:BaseButton;
      
      private var _okBtn:BaseButton;
      
      private var _buyBtn:BaseButton;
      
      private var _prizeListBtn:BaseButton;
      
      private var firstTicket:MovieClip;
      
      private var secondTicket:MovieClip;
      
      private var thirdTicket:MovieClip;
      
      private var fourthTicket:MovieClip;
      
      private var isFour:Array;
      
      private var count:int = 16;
      
      private var selectArr:Array;
      
      private var ticketArr:Array;
      
      private var _list:ListPanel;
      
      private var prizeBox:Sprite;
      
      private var closeBtn:BaseButton;
      
      private var _help:HelperHelpBtnCreate;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var canBuyArr:Array;
      
      private var _frame:LotteryPrizeView;
      
      public function LotteryMainView()
      {
         isFour = [0,0,0,0];
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         var _loc12_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc8_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.lotteryTicket.bg");
         addChild(_bg);
         _prizeMoney = ComponentFactory.Instance.creatNumberSprite(LotteryManager.instance.model.poolCount,"asset.lotteryTicket.num",-3);
         addChild(_prizeMoney);
         PositionUtils.setPos(_prizeMoney,"asset.lotteryTicket.prizeMoney.pos");
         _activityTimeTxt = ComponentFactory.Instance.creatComponentByStylename("asset.lotteryTicket.activityTime.txt");
         addChild(_activityTimeTxt);
         _activityTimeTxt.text = LanguageMgr.GetTranslation("asset.lotteryTicket.activityTime",ServerConfigManager.instance.getTwoColorBallBeginTime(),ServerConfigManager.instance.getTwoColorBallEndTime());
         _openTimeTxt = ComponentFactory.Instance.creatComponentByStylename("asset.lotteryTicket.openTime.txt");
         addChild(_openTimeTxt);
         _openTimeTxt.text = LanguageMgr.GetTranslation("asset.lotteryTicket.openTime","21:00");
         _randomBtn = ComponentFactory.Instance.creatComponentByStylename("lotteryTicket.randomBtn");
         addChild(_randomBtn);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("lotteryTicket.okBtn");
         addChild(_okBtn);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("lotteryTicket.buyBtn");
         addChild(_buyBtn);
         _prizeListBtn = ComponentFactory.Instance.creatComponentByStylename("lotteryTicket.prizeListBtn");
         addChild(_prizeListBtn);
         if(LotteryManager.instance.model.displayResults == "")
         {
            _prizeListBtn.enable = false;
         }
         selectArr = [];
         _loc12_ = 0;
         while(_loc12_ < count)
         {
            _loc4_ = ClassUtils.CreatInstance("asset.lotteryTicket.select");
            _loc4_.pos = _loc12_;
            PositionUtils.setPos(_loc4_,"asset.lotteryTicket.select.pos" + String(_loc12_));
            _loc4_.gotoAndStop(1);
            addChild(_loc4_);
            _loc4_.addEventListener("click",selectHandler);
            selectArr.push(_loc4_);
            _loc12_++;
         }
         ticketArr = [];
         firstTicket = ClassUtils.CreatInstance("asset.lotteryTicket.ticket");
         secondTicket = ClassUtils.CreatInstance("asset.lotteryTicket.ticket");
         thirdTicket = ClassUtils.CreatInstance("asset.lotteryTicket.ticket");
         fourthTicket = ClassUtils.CreatInstance("asset.lotteryTicket.ticket");
         PositionUtils.setPos(firstTicket,"asset.lotteryTicket.ticket.pos1");
         PositionUtils.setPos(secondTicket,"asset.lotteryTicket.ticket.pos2");
         PositionUtils.setPos(thirdTicket,"asset.lotteryTicket.ticket.pos3");
         PositionUtils.setPos(fourthTicket,"asset.lotteryTicket.ticket.pos4");
         addChild(firstTicket);
         addChild(secondTicket);
         addChild(thirdTicket);
         addChild(fourthTicket);
         firstTicket.gotoAndStop(count + 1);
         secondTicket.gotoAndStop(count + 1);
         thirdTicket.gotoAndStop(count + 1);
         fourthTicket.gotoAndStop(count + 1);
         ticketArr = [firstTicket,secondTicket,thirdTicket,fourthTicket];
         _list = ComponentFactory.Instance.creatComponentByStylename("lotteryTicket.cellList");
         addChild(_list);
         prizeBox = new Sprite();
         addChild(prizeBox);
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         _loc10_ = 0;
         while(_loc10_ < LotteryManager.instance.model.itemInfoList.length)
         {
            _loc11_ = LotteryManager.instance.model.itemInfoList[_loc10_] as LotteryRewardInfo;
            _loc1_ = new InventoryItemInfo();
            _loc1_.TemplateID = _loc11_.TemplateID;
            _loc1_ = ItemManager.fill(_loc1_);
            _loc1_.IsBinds = _loc11_.IsBind;
            _loc1_.ValidDate = _loc11_.ValidDate;
            _loc1_.StrengthenLevel = _loc11_.StrengthLevel;
            _loc1_.AttackCompose = _loc11_.AttackCompose;
            _loc1_.DefendCompose = _loc11_.DefendCompose;
            _loc1_.AgilityCompose = _loc11_.AgilityCompose;
            _loc1_.LuckCompose = _loc11_.LuckCompose;
            _loc1_.Count = _loc11_.Count;
            _loc5_ = new BagCell(0,_loc1_,false,ComponentFactory.Instance.creatBitmap("asset.lotteryTicket.prize.bg"));
            _loc5_.BGVisible = true;
            _loc5_.setContentSize(40,40);
            if(_loc11_.Quality == 1)
            {
               _loc5_.x = _loc3_ * 50 + 595;
               _loc5_.y = 313;
               _loc3_++;
            }
            else if(_loc11_.Quality == 2)
            {
               _loc5_.x = _loc7_ * 50 + 595;
               _loc5_.y = 394;
               _loc7_++;
            }
            else if(_loc11_.Quality == 3)
            {
               _loc5_.x = _loc9_ * 50 + 595;
               _loc5_.y = 471;
               _loc9_++;
            }
            prizeBox.addChild(_loc5_);
            _loc10_++;
         }
         if(LotteryManager.instance.model.displayResults.length > 0)
         {
            _loc10_ = 0;
            while(_loc10_ < LotteryManager.instance.model.displayResults.length)
            {
               _loc2_ = ClassUtils.CreatInstance("asset.lotteryTicket.ticket");
               addChild(_loc2_);
               _loc2_.x = 602 + _loc10_ * 63;
               _loc2_.y = 167;
               _loc2_.gotoAndStop(parseInt(LotteryManager.instance.model.displayResults.substr(_loc10_,1),16) + 1);
               _loc10_++;
            }
         }
         else
         {
            _loc10_ = 0;
            while(_loc10_ < 4)
            {
               _loc8_ = ComponentFactory.Instance.creatBitmap("asset.lotteryTicket.question");
               addChild(_loc8_);
               _loc8_.x = 613 + _loc10_ * 63;
               _loc8_.y = 169;
               _loc10_++;
            }
         }
         closeBtn = ComponentFactory.Instance.creatComponentByStylename("lotteryTicket.closeBtn");
         addChild(closeBtn);
         _help = new HelperHelpBtnCreate();
         _help.create(this,"asset.lotteryTicket.help",null,new Point(783,92),LanguageMgr.GetTranslation("AlertDialog.help"));
      }
      
      public function initData() : void
      {
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(LotteryManager.instance.model.dataList);
         _list.list.updateListView();
      }
      
      private function ticketHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget.currentFrame == count + 1)
         {
            return;
         }
         var _loc2_:* = param1.currentTarget;
         if(firstTicket !== _loc2_)
         {
            if(secondTicket !== _loc2_)
            {
               if(thirdTicket !== _loc2_)
               {
                  if(fourthTicket === _loc2_)
                  {
                     isFour[3] = 0;
                  }
               }
               else
               {
                  isFour[2] = 0;
               }
            }
            else
            {
               isFour[1] = 0;
            }
         }
         else
         {
            isFour[0] = 0;
         }
         selectArr[param1.currentTarget.currentFrame - 1].gotoAndStop(1);
         param1.currentTarget.gotoAndStop(count + 1);
      }
      
      private function cleanAllSelect() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < selectArr.length)
         {
            selectArr[_loc1_].gotoAndStop(1);
            _loc1_++;
         }
      }
      
      private function selectHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = isFour.indexOf(0);
         if(_loc2_ == -1 || param1.currentTarget.currentFrame == 2)
         {
            return;
         }
         isFour[_loc2_] = param1.currentTarget.pos + 1;
         ticketArr[_loc2_].gotoAndStop(param1.currentTarget.pos + 1);
         param1.currentTarget.gotoAndStop(2);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _randomBtn.addEventListener("click",randomBtnHander);
         _okBtn.addEventListener("click",okBtnHander);
         _buyBtn.addEventListener("click",buyBtnHander);
         _prizeListBtn.addEventListener("click",prizeListBtnHander);
         firstTicket.addEventListener("click",ticketHandler);
         secondTicket.addEventListener("click",ticketHandler);
         thirdTicket.addEventListener("click",ticketHandler);
         fourthTicket.addEventListener("click",ticketHandler);
         closeBtn.addEventListener("click",closeHandler);
         LotteryManager.instance.addEventListener("deleteCell",deleteHandler);
      }
      
      private function closeHandler(param1:MouseEvent) : void
      {
         LotteryManager.instance.closeFrame();
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode) - 1)
         {
            case 0:
               LotteryManager.instance.closeFrame();
               break;
            default:
               LotteryManager.instance.closeFrame();
               break;
            default:
               LotteryManager.instance.closeFrame();
               break;
            case 3:
         }
      }
      
      private function randomBtnHander(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         cleanAllSelect();
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc2_ = Math.floor(16 * Math.random());
            if(isFour.indexOf(_loc2_ + 1) != -1)
            {
               _loc3_--;
            }
            else
            {
               isFour[_loc3_] = _loc2_ + 1;
               ticketArr[_loc3_].gotoAndStop(_loc2_ + 1);
               selectArr[_loc2_].gotoAndStop(2);
            }
            _loc3_++;
         }
      }
      
      private function okBtnHander(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         if(!LotteryManager.instance.model.isCanBuyBall)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("asset.lotteryTicket.joinFail3"));
            return;
         }
         if(LotteryManager.instance.model.dataList.length == 8)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("asset.lotteryTicket.joinFail2"));
            return;
         }
         var _loc2_:int = isFour.indexOf(0);
         if(_loc2_ != -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("asset.lotteryTicket.joinFail1"));
            return;
         }
         var _loc4_:LotteryTicketInfo = new LotteryTicketInfo();
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc4_.ticketArr[_loc3_] = (isFour[_loc3_] - 1).toString(16);
            _loc3_++;
         }
         _loc4_.ifBuy = false;
         LotteryManager.instance.model.dataList.push(_loc4_);
         initData();
      }
      
      private function buyBtnHander(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         canBuyArr = [];
         _loc4_ = 0;
         while(_loc4_ < LotteryManager.instance.model.dataList.length)
         {
            _loc3_ = LotteryManager.instance.model.dataList[_loc4_];
            if(!_loc3_.ifBuy)
            {
               canBuyArr.push(_loc3_);
            }
            _loc4_++;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(canBuyArr.length == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("asset.lotteryTicket.joinFail4"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("asset.lotteryTicket.howmuchmoney",100 * canBuyArr.length,canBuyArr.length);
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("ddt.vip.vipFrame.ConfirmTitle"),_loc2_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,1,null,"SimpleAlert",30,true,0);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirm);
      }
      
      private function __confirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               CheckMoneyUtils.instance.checkMoney(_confirmFrame.isBand,100 * canBuyArr.length,onCompleteHandler);
         }
         _confirmFrame.removeEventListener("response",__confirm);
         _confirmFrame.dispose();
         if(_confirmFrame.parent)
         {
            _confirmFrame.parent.removeChild(_confirmFrame);
         }
      }
      
      private function onCompleteHandler() : void
      {
         SocketManager.Instance.out.buyLotteryTicket(LotteryManager.instance.model.gameIndex,canBuyArr);
      }
      
      private function prizeListBtnHander(param1:MouseEvent) : void
      {
         _frame = ComponentFactory.Instance.creatCustomObject("Lottery.lotteryPrizeView");
         _frame.titleText = LanguageMgr.GetTranslation("asset.lotteryTicket.prizeList");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function deleteHandler(param1:LotteryTicketEvent) : void
      {
         initData();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _randomBtn.removeEventListener("click",randomBtnHander);
         _okBtn.removeEventListener("click",okBtnHander);
         _buyBtn.removeEventListener("click",buyBtnHander);
         _prizeListBtn.removeEventListener("click",prizeListBtnHander);
         firstTicket.removeEventListener("click",ticketHandler);
         secondTicket.removeEventListener("click",ticketHandler);
         thirdTicket.removeEventListener("click",ticketHandler);
         fourthTicket.removeEventListener("click",ticketHandler);
         closeBtn.removeEventListener("click",closeHandler);
         LotteryManager.instance.removeEventListener("deleteCell",deleteHandler);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         LotteryManager.instance.isClick = false;
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_prizeMoney)
         {
            ObjectUtils.disposeObject(_prizeMoney);
         }
         _prizeMoney = null;
         if(_activityTimeTxt)
         {
            ObjectUtils.disposeObject(_activityTimeTxt);
         }
         _activityTimeTxt = null;
         if(_openTimeTxt)
         {
            ObjectUtils.disposeObject(_openTimeTxt);
         }
         _openTimeTxt = null;
         if(_randomBtn)
         {
            ObjectUtils.disposeObject(_randomBtn);
         }
         _randomBtn = null;
         if(_okBtn)
         {
            ObjectUtils.disposeObject(_okBtn);
         }
         _okBtn = null;
         if(_buyBtn)
         {
            ObjectUtils.disposeObject(_buyBtn);
         }
         _buyBtn = null;
         if(_prizeListBtn)
         {
            ObjectUtils.disposeObject(_prizeListBtn);
         }
         _prizeListBtn = null;
         if(firstTicket)
         {
            ObjectUtils.disposeObject(firstTicket);
         }
         firstTicket = null;
         if(secondTicket)
         {
            ObjectUtils.disposeObject(secondTicket);
         }
         secondTicket = null;
         if(thirdTicket)
         {
            ObjectUtils.disposeObject(thirdTicket);
         }
         thirdTicket = null;
         if(fourthTicket)
         {
            ObjectUtils.disposeObject(fourthTicket);
         }
         fourthTicket = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_help)
         {
            ObjectUtils.disposeObject(_help);
         }
         _help = null;
         _loc1_ = 0;
         while(_loc1_ < selectArr.length)
         {
            selectArr[_loc1_].removeEventListener("click",selectHandler);
            ObjectUtils.disposeObject(selectArr[_loc1_]);
            _loc1_++;
         }
         dispatchEvent(new KeyboardEvent("keyDown",true,false,27));
         super.dispose();
      }
   }
}
