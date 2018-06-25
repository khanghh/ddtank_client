package kingBless.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddtBuried.BuriedManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import kingBless.KingBlessManager;
   import shop.view.ShopPresentClearingFrame;
   
   public class KingBlessMainFrame extends Frame
   {
       
      
      private var _awardIconBtnBg:Bitmap;
      
      private var _monthBtnBg:Bitmap;
      
      private var _bottomBg:Bitmap;
      
      private var _txtBg:Bitmap;
      
      private var _oneMonthBtn:SelectedButton;
      
      private var _threeMonthBtn:SelectedButton;
      
      private var _sixMonthBtn:SelectedButton;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      private var _openFriendBtn:SimpleBitmapButton;
      
      private var _openBtn:SimpleBitmapButton;
      
      private var _awardIconList:Vector.<Image>;
      
      private var _awardNameTxtList:Vector.<FilterFrameText>;
      
      private var _tipTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _nameList:Array;
      
      private var _descList:Array;
      
      private var _tipList:Array;
      
      private var _tipNoOpenTxt:String;
      
      private var _needMoneyList:Array;
      
      private var _needMoneyArray:Array;
      
      private var _openTimeDescList:Array;
      
      private var _giveFriendOpenFrame:ShopPresentClearingFrame;
      
      private var _discountIcon:ScaleLeftRightImage;
      
      private var _discountIcon1:ScaleLeftRightImage;
      
      private var _discountIcon2:ScaleLeftRightImage;
      
      private var _discountTxt:FilterFrameText;
      
      private var _discountTxt1:FilterFrameText;
      
      private var _discountTxt2:FilterFrameText;
      
      private var _halfYearTxt:FilterFrameText;
      
      private var _threeMonthTxt:FilterFrameText;
      
      private var _oneMonthTxt:FilterFrameText;
      
      private var _friendInfo:Object;
      
      private var payMoney:int;
      
      private var _isGive:Boolean;
      
      public function KingBlessMainFrame()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         var i:int = 0;
         var tmparray:* = null;
         var j:int = 0;
         _nameList = LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardNameTxtList").split(",");
         _descList = [];
         _tipList = [];
         for(i = 1; i <= 3; )
         {
            _tipList.push(LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardTipTxt" + i));
            tmparray = [];
            for(j = 1; j <= 7; )
            {
               tmparray.push(LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardDescTxt" + i.toString() + j.toString()));
               j++;
            }
            _descList.push(tmparray);
            i++;
         }
         _tipNoOpenTxt = LanguageMgr.GetTranslation("ddt.kingBlessFrame.noOpenTipTxt");
         _needMoneyList = ServerConfigManager.instance.kingBuffPrice.split(",");
         _needMoneyArray = ServerConfigManager.instance.kingBuffPriceDiscount.split(",");
         _openTimeDescList = LanguageMgr.GetTranslation("ddt.kingBlessFrame.openTime").split(",");
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var image:* = null;
         var txt:* = null;
         titleText = LanguageMgr.GetTranslation("ddt.kingBlessFrame.titleTxt");
         _awardIconBtnBg = ComponentFactory.Instance.creatBitmap("asset.kingbless.awardIconBtnBg");
         _monthBtnBg = ComponentFactory.Instance.creatBitmap("asset.kingbless.monthBtnBg");
         _bottomBg = ComponentFactory.Instance.creatBitmap("asset.kingbless.bottomBg");
         _txtBg = ComponentFactory.Instance.creatBitmap("asset.kingbless.txtBg");
         _oneMonthBtn = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.oneMonthBtn");
         _threeMonthBtn = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.threeMonthBtn");
         _sixMonthBtn = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.sixMonthBtn");
         _selectedButtonGroup = new SelectedButtonGroup();
         _selectedButtonGroup.addSelectItem(_oneMonthBtn);
         _selectedButtonGroup.addSelectItem(_threeMonthBtn);
         _selectedButtonGroup.addSelectItem(_sixMonthBtn);
         _selectedButtonGroup.selectIndex = 2;
         _openFriendBtn = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.openFriendBtn");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.openBtn");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.tipTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.descTxt");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.txtVBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.txtScrollPanel");
         _halfYearTxt = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.halfYearTxt");
         _threeMonthTxt = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.threeMonthTxt");
         _oneMonthTxt = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.oneMonthTxt");
         _halfYearTxt.htmlText = LanguageMgr.GetTranslation("ddt.kingBlessFrame.halfYearDiscount",int(PlayerManager.Instance.kingBuffPriceArr[2]) > 0?PlayerManager.Instance.kingBuffPriceArr[2]:_needMoneyList[2]);
         _threeMonthTxt.htmlText = LanguageMgr.GetTranslation("ddt.kingBlessFrame.threeMonthDiscount",int(PlayerManager.Instance.kingBuffPriceArr[1]) > 0?PlayerManager.Instance.kingBuffPriceArr[1]:_needMoneyList[1]);
         _oneMonthTxt.htmlText = LanguageMgr.GetTranslation("ddt.kingBlessFrame.oneMonthDiscount",int(PlayerManager.Instance.kingBuffPriceArr[0]) > 0?PlayerManager.Instance.kingBuffPriceArr[0]:_needMoneyList[0]);
         _discountIcon = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.discount.image");
         _discountIcon1 = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.discount.image");
         PositionUtils.setPos(_discountIcon1,"kingBlessFrame.discount.image.threeMonthPos");
         _discountIcon2 = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.discount.image");
         PositionUtils.setPos(_discountIcon2,"kingBlessFrame.discount.image.oneMonthPos");
         _discountTxt = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.discount.imageTxt");
         _discountTxt.x = _discountIcon.x + 1;
         _discountTxt.y = _discountIcon.y + 2;
         _discountTxt.width = _discountIcon.width;
         _discountTxt1 = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.discount.imageTxt");
         _discountTxt1.x = _discountIcon1.x + 1;
         _discountTxt1.y = _discountIcon1.y + 2;
         _discountTxt1.width = _discountIcon1.width;
         _discountTxt2 = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.discount.imageTxt");
         _discountTxt2.x = _discountIcon2.x + 1;
         _discountTxt2.y = _discountIcon2.y + 2;
         _discountTxt2.width = _discountIcon2.width;
         if(Number(PlayerManager.Instance.kingBuffDiscountArr[2]) > 0)
         {
            _discountTxt.text = LanguageMgr.GetTranslation("ddt.vipView.discountIconTxt",100 - PlayerManager.Instance.kingBuffDiscountArr[2] * 10);
            _discountIcon.visible = true;
         }
         else
         {
            _discountTxt.text = "";
            _discountIcon.visible = false;
         }
         if(Number(PlayerManager.Instance.kingBuffDiscountArr[1]) > 0)
         {
            _discountTxt1.text = LanguageMgr.GetTranslation("ddt.vipView.discountIconTxt",100 - PlayerManager.Instance.kingBuffDiscountArr[1] * 10);
            _discountIcon1.visible = true;
         }
         else
         {
            _discountTxt1.text = "";
            _discountIcon1.visible = false;
         }
         if(Number(PlayerManager.Instance.kingBuffDiscountArr[0]) > 0)
         {
            _discountTxt2.text = LanguageMgr.GetTranslation("ddt.vipView.discountIconTxt",100 - PlayerManager.Instance.kingBuffDiscountArr[0] * 10);
            _discountIcon2.visible = true;
         }
         else
         {
            _discountTxt2.text = "";
            _discountIcon2.visible = false;
         }
         addToContent(_awardIconBtnBg);
         addToContent(_monthBtnBg);
         addToContent(_bottomBg);
         addToContent(_txtBg);
         addToContent(_oneMonthBtn);
         addToContent(_threeMonthBtn);
         addToContent(_sixMonthBtn);
         addToContent(_scrollPanel);
         addToContent(_openFriendBtn);
         addToContent(_openBtn);
         addToContent(_halfYearTxt);
         addToContent(_threeMonthTxt);
         addToContent(_oneMonthTxt);
         if(PlayerManager.Instance.kingBuffDiscountArr[0] != null && Number(PlayerManager.Instance.kingBuffDiscountArr[0]) > 0)
         {
            addToContent(_discountIcon);
         }
         if(PlayerManager.Instance.kingBuffDiscountArr[1] != null && Number(PlayerManager.Instance.kingBuffDiscountArr[1]) > 0)
         {
            addToContent(_discountIcon1);
         }
         if(PlayerManager.Instance.kingBuffDiscountArr[2] != null && Number(PlayerManager.Instance.kingBuffDiscountArr[2]) > 0)
         {
            addToContent(_discountIcon2);
         }
         if(PlayerManager.Instance.kingBuffDiscountArr[0] != null && Number(PlayerManager.Instance.kingBuffDiscountArr[0]) > 0)
         {
            addToContent(_discountTxt);
         }
         if(PlayerManager.Instance.kingBuffDiscountArr[1] != null && Number(PlayerManager.Instance.kingBuffDiscountArr[1]) > 0)
         {
            addToContent(_discountTxt1);
         }
         if(PlayerManager.Instance.kingBuffDiscountArr[2] != null && Number(PlayerManager.Instance.kingBuffDiscountArr[2]) > 0)
         {
            addToContent(_discountTxt2);
         }
         _awardIconList = new Vector.<Image>(6);
         _awardNameTxtList = new Vector.<FilterFrameText>(6);
         for(i = 0; i < 7; )
         {
            if(i != 5)
            {
               image = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.awardIcon");
               image.resourceLink = "asset.kingbless.awardIcon" + (i + 1);
               txt = ComponentFactory.Instance.creatComponentByStylename("kingBlessFrame.iconNameTxt");
               txt.text = _nameList[i];
               if(i > 5)
               {
                  image.x = image.x + (i - 1) * 79;
                  txt.x = txt.x + (i - 1) * 79;
               }
               else
               {
                  image.x = image.x + i * 79;
                  txt.x = txt.x + i * 79;
               }
               addToContent(image);
               addToContent(txt);
               _awardIconList[i] = image;
               _awardNameTxtList[i] = txt;
            }
            i++;
         }
         refreshIconTipData();
         refreshShowTxt();
         refreshOpenBtn();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _selectedButtonGroup.addEventListener("change",selectedButtonChange,false,0,true);
         KingBlessManager.instance.addEventListener("update_main_event",refreshView);
         _openFriendBtn.addEventListener("click",openFriendHandler,false,0,true);
         _openBtn.addEventListener("click",openHandler,false,0,true);
      }
      
      private function openHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!judgeOpen())
         {
            return;
         }
         openConfirmFrame();
      }
      
      private function judgeOpen() : Boolean
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return false;
         }
         var index:int = _selectedButtonGroup.selectIndex;
         payMoney = int(PlayerManager.Instance.kingBuffPriceArr[index]) > 0?PlayerManager.Instance.kingBuffPriceArr[index]:_needMoneyList[index];
         return true;
      }
      
      private function openConfirmFrame() : void
      {
         var msg:* = null;
         var confirmFrame:* = null;
         var index:int = _selectedButtonGroup.selectIndex;
         if(!_friendInfo)
         {
            msg = LanguageMgr.GetTranslation("ddt.kingBlessFrame.openPromptTxt",_openTimeDescList[index],payMoney);
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"SimpleAlert",30,true,0);
            confirmFrame.moveEnable = false;
            confirmFrame.addEventListener("response",__confirm);
            _isGive = false;
         }
         else
         {
            _isGive = true;
            msg = LanguageMgr.GetTranslation("ddt.kingBlessFrame.openFriendPromptTxt",_friendInfo["name"],_openTimeDescList[index],payMoney);
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            confirmFrame.moveEnable = false;
            confirmFrame.isBand = false;
            confirmFrame.addEventListener("response",__confirm);
         }
      }
      
      private function __confirm(evt:FrameEvent) : void
      {
         var id:int = 0;
         var msg:* = null;
         var type:int = 0;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            if(!_friendInfo)
            {
               id = PlayerManager.Instance.Self.ID;
               msg = "";
            }
            else
            {
               id = _friendInfo["id"];
               msg = _friendInfo["msg"];
            }
            type = _selectedButtonGroup.selectIndex + 1;
            if(!_isGive)
            {
               if(BuriedManager.Instance.checkMoney(confirmFrame.isBand,payMoney))
               {
                  return;
               }
               SocketManager.Instance.out.sendOpenKingBless(type,id,msg,confirmFrame.isBand);
               confirmFrame.dispose();
            }
            else if(!confirmFrame.isBand && PlayerManager.Instance.Self.Money >= payMoney)
            {
               SocketManager.Instance.out.sendOpenKingBless(type,id,msg,confirmFrame.isBand);
            }
            else
            {
               LeavePageManager.showFillFrame();
               confirmFrame.dispose();
               return;
            }
         }
         confirmFrame.removeEventListener("response",__confirm);
         _friendInfo = null;
      }
      
      private function openFriendHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!judgeOpen())
         {
            return;
         }
         _giveFriendOpenFrame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ShopPresentClearingFrame");
         _giveFriendOpenFrame.nameInput.enable = false;
         _giveFriendOpenFrame.titleTxt.visible = false;
         _giveFriendOpenFrame.setType();
         _giveFriendOpenFrame.show();
         _giveFriendOpenFrame.presentBtn.addEventListener("click",__presentBtnClick,false,0,true);
         _giveFriendOpenFrame.addEventListener("response",__responseHandler2,false,0,true);
      }
      
      private function __responseHandler2(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1 || event.responseCode == 4)
         {
            StageReferance.stage.focus = this;
            _giveFriendOpenFrame = null;
         }
      }
      
      private function __presentBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var name:String = _giveFriendOpenFrame.nameInput.text;
         if(name == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.give"));
            return;
         }
         if(FilterWordManager.IsNullorEmpty(name))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.space"));
            return;
         }
         _friendInfo = {};
         _friendInfo["id"] = _giveFriendOpenFrame.selectPlayerId;
         _friendInfo["name"] = name;
         _friendInfo["msg"] = FilterWordManager.filterWrod(_giveFriendOpenFrame.textArea.text);
         openConfirmFrame();
      }
      
      private function refreshView(event:Event) : void
      {
         refreshIconTipData();
         refreshOpenBtn();
      }
      
      private function selectedButtonChange(event:Event) : void
      {
         SoundManager.instance.play("008");
         refreshShowTxt();
      }
      
      private function refreshOpenBtn() : void
      {
         var openType:int = KingBlessManager.instance.openType;
         if(openType > 0)
         {
            _openBtn.backStyle = "asset.kingbless.renewBtn";
         }
         else
         {
            _openBtn.backStyle = "asset.kingbless.openBtn";
         }
      }
      
      private function refreshIconTipData() : void
      {
         var i:int = 0;
         var openType:int = KingBlessManager.instance.openType;
         for(i = 0; i < 7; )
         {
            if(i != 5)
            {
               if(openType > 0)
               {
                  _awardIconList[i].tipData = _descList[openType - 1][i];
               }
               else
               {
                  _awardIconList[i].tipData = _tipNoOpenTxt;
               }
            }
            i++;
         }
      }
      
      private function refreshShowTxt() : void
      {
         var i:int = 0;
         var tmp:* = null;
         var array:* = null;
         var index:int = _selectedButtonGroup.selectIndex;
         _tipTxt.text = _tipList[index];
         var tmpDescList:Array = _descList[index];
         var tmpStr:String = "";
         for(i = 0; i < 7; )
         {
            if(i != 5)
            {
               tmp = tmpDescList[i];
               array = tmp.match(/\d+/);
               if(array && array.length > 0)
               {
                  tmp = tmp.replace(array[0],"<FONT COLOR=\'#FF0000\'>" + array[0] + "</FONT>");
               }
               if(i > 5)
               {
                  tmpStr = tmpStr + (LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardDescTxt",i.toString(),_nameList[i],tmp) + "\n");
               }
               else
               {
                  tmpStr = tmpStr + (LanguageMgr.GetTranslation("ddt.kingBlessFrame.awardDescTxt",(i + 1).toString(),_nameList[i],tmp) + "\n");
               }
            }
            i++;
         }
         _descTxt.htmlText = tmpStr;
         _vbox.addChild(_tipTxt);
         _vbox.addChild(_descTxt);
         _scrollPanel.setView(_vbox);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _selectedButtonGroup.removeEventListener("change",selectedButtonChange);
         KingBlessManager.instance.removeEventListener("update_main_event",refreshView);
         _openFriendBtn.removeEventListener("click",openFriendHandler);
         _openBtn.removeEventListener("click",openHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_awardIconBtnBg);
         _awardIconBtnBg = null;
         ObjectUtils.disposeObject(_monthBtnBg);
         _monthBtnBg = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_txtBg);
         _txtBg = null;
         ObjectUtils.disposeObject(_selectedButtonGroup);
         _selectedButtonGroup = null;
         ObjectUtils.disposeObject(_oneMonthBtn);
         _oneMonthBtn = null;
         ObjectUtils.disposeObject(_threeMonthBtn);
         _threeMonthBtn = null;
         ObjectUtils.disposeObject(_sixMonthBtn);
         _sixMonthBtn = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         ObjectUtils.disposeObject(_openFriendBtn);
         _openFriendBtn = null;
         ObjectUtils.disposeObject(_giveFriendOpenFrame);
         _giveFriendOpenFrame = null;
         ObjectUtils.disposeObject(_discountIcon);
         _discountIcon = null;
         ObjectUtils.disposeObject(_discountIcon1);
         _discountIcon1 = null;
         ObjectUtils.disposeObject(_discountIcon2);
         _discountIcon2 = null;
         ObjectUtils.disposeObject(_discountTxt);
         _discountTxt = null;
         ObjectUtils.disposeObject(_discountTxt1);
         _discountTxt1 = null;
         ObjectUtils.disposeObject(_discountTxt2);
         _discountTxt2 = null;
         ObjectUtils.disposeObject(_halfYearTxt);
         _halfYearTxt = null;
         ObjectUtils.disposeObject(_threeMonthTxt);
         _threeMonthTxt = null;
         ObjectUtils.disposeObject(_oneMonthTxt);
         _oneMonthTxt = null;
         var _loc4_:int = 0;
         var _loc3_:* = _awardIconList;
         for each(var image in _awardIconList)
         {
            ObjectUtils.disposeObject(image);
         }
         _awardIconList = null;
         var _loc6_:int = 0;
         var _loc5_:* = _awardNameTxtList;
         for each(var txt in _awardNameTxtList)
         {
            ObjectUtils.disposeObject(txt);
         }
         _awardNameTxtList = null;
         _nameList = null;
         _descList = null;
         super.dispose();
      }
   }
}
