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
         var i:int = 0;
         var select:* = null;
         var itemInfo:* = null;
         var tInfo:* = null;
         var j:int = 0;
         var info:* = null;
         var cell:* = null;
         var ticket:* = null;
         var question:* = null;
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
         for(i = 0; i < count; )
         {
            select = ClassUtils.CreatInstance("asset.lotteryTicket.select");
            select.pos = i;
            PositionUtils.setPos(select,"asset.lotteryTicket.select.pos" + String(i));
            select.gotoAndStop(1);
            addChild(select);
            select.addEventListener("click",selectHandler);
            selectArr.push(select);
            i++;
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
         var index1:int = 0;
         var index2:int = 0;
         var index3:int = 0;
         for(j = 0; j < LotteryManager.instance.model.itemInfoList.length; )
         {
            info = LotteryManager.instance.model.itemInfoList[j] as LotteryRewardInfo;
            tInfo = new InventoryItemInfo();
            tInfo.TemplateID = info.TemplateID;
            tInfo = ItemManager.fill(tInfo);
            tInfo.IsBinds = info.IsBind;
            tInfo.ValidDate = info.ValidDate;
            tInfo.StrengthenLevel = info.StrengthLevel;
            tInfo.AttackCompose = info.AttackCompose;
            tInfo.DefendCompose = info.DefendCompose;
            tInfo.AgilityCompose = info.AgilityCompose;
            tInfo.LuckCompose = info.LuckCompose;
            tInfo.Count = info.Count;
            cell = new BagCell(0,tInfo,false,ComponentFactory.Instance.creatBitmap("asset.lotteryTicket.prize.bg"));
            cell.BGVisible = true;
            cell.setContentSize(40,40);
            if(info.Quality == 1)
            {
               cell.x = index1 * 50 + 595;
               cell.y = 313;
               index1++;
            }
            else if(info.Quality == 2)
            {
               cell.x = index2 * 50 + 595;
               cell.y = 394;
               index2++;
            }
            else if(info.Quality == 3)
            {
               cell.x = index3 * 50 + 595;
               cell.y = 471;
               index3++;
            }
            prizeBox.addChild(cell);
            j++;
         }
         if(LotteryManager.instance.model.displayResults.length > 0)
         {
            for(j = 0; j < LotteryManager.instance.model.displayResults.length; )
            {
               ticket = ClassUtils.CreatInstance("asset.lotteryTicket.ticket");
               addChild(ticket);
               ticket.x = 602 + j * 63;
               ticket.y = 167;
               ticket.gotoAndStop(parseInt(LotteryManager.instance.model.displayResults.substr(j,1),16) + 1);
               j++;
            }
         }
         else
         {
            j = 0;
            while(j < 4)
            {
               question = ComponentFactory.Instance.creatBitmap("asset.lotteryTicket.question");
               addChild(question);
               question.x = 613 + j * 63;
               question.y = 169;
               j++;
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
      
      private function ticketHandler(e:MouseEvent) : void
      {
         if(e.currentTarget.currentFrame == count + 1)
         {
            return;
         }
         var _loc2_:* = e.currentTarget;
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
         selectArr[e.currentTarget.currentFrame - 1].gotoAndStop(1);
         e.currentTarget.gotoAndStop(count + 1);
      }
      
      private function cleanAllSelect() : void
      {
         var i:int = 0;
         for(i = 0; i < selectArr.length; )
         {
            selectArr[i].gotoAndStop(1);
            i++;
         }
      }
      
      private function selectHandler(e:MouseEvent) : void
      {
         var index:int = isFour.indexOf(0);
         if(index == -1 || e.currentTarget.currentFrame == 2)
         {
            return;
         }
         isFour[index] = e.currentTarget.pos + 1;
         ticketArr[index].gotoAndStop(e.currentTarget.pos + 1);
         e.currentTarget.gotoAndStop(2);
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
      
      private function closeHandler(e:MouseEvent) : void
      {
         LotteryManager.instance.closeFrame();
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode) - 1)
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
      
      private function randomBtnHander(e:MouseEvent) : void
      {
         var i:int = 0;
         var randomNum:int = 0;
         cleanAllSelect();
         for(i = 0; i < 4; )
         {
            randomNum = Math.floor(16 * Math.random());
            if(isFour.indexOf(randomNum + 1) != -1)
            {
               i--;
            }
            else
            {
               isFour[i] = randomNum + 1;
               ticketArr[i].gotoAndStop(randomNum + 1);
               selectArr[randomNum].gotoAndStop(2);
            }
            i++;
         }
      }
      
      private function okBtnHander(e:MouseEvent) : void
      {
         var i:int = 0;
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
         var index:int = isFour.indexOf(0);
         if(index != -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("asset.lotteryTicket.joinFail1"));
            return;
         }
         var info:LotteryTicketInfo = new LotteryTicketInfo();
         for(i = 0; i < 4; )
         {
            info.ticketArr[i] = (isFour[i] - 1).toString(16);
            i++;
         }
         info.ifBuy = false;
         LotteryManager.instance.model.dataList.push(info);
         initData();
      }
      
      private function buyBtnHander(e:MouseEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         canBuyArr = [];
         for(i = 0; i < LotteryManager.instance.model.dataList.length; )
         {
            info = LotteryManager.instance.model.dataList[i];
            if(!info.ifBuy)
            {
               canBuyArr.push(info);
            }
            i++;
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
         var msg:String = LanguageMgr.GetTranslation("asset.lotteryTicket.howmuchmoney",100 * canBuyArr.length,canBuyArr.length);
         _confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("ddt.vip.vipFrame.ConfirmTitle"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,1,null,"SimpleAlert",30,true,0);
         _confirmFrame.moveEnable = false;
         _confirmFrame.addEventListener("response",__confirm);
      }
      
      private function __confirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode) - 2)
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
      
      private function prizeListBtnHander(e:MouseEvent) : void
      {
         _frame = ComponentFactory.Instance.creatCustomObject("Lottery.lotteryPrizeView");
         _frame.titleText = LanguageMgr.GetTranslation("asset.lotteryTicket.prizeList");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function deleteHandler(e:LotteryTicketEvent) : void
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
         var i:int = 0;
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
         for(i = 0; i < selectArr.length; )
         {
            selectArr[i].removeEventListener("click",selectHandler);
            ObjectUtils.disposeObject(selectArr[i]);
            i++;
         }
         dispatchEvent(new KeyboardEvent("keyDown",true,false,27));
         super.dispose();
      }
   }
}
