package texpSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import quest.TaskManager;
   import shop.view.NewShopBugleView;
   import shop.view.NewShopMultiBugleView;
   import shop.view.SetsShopView;
   import texpSystem.TexpEvent;
   import texpSystem.controller.TexpManager;
   import texpSystem.data.TexpInfo;
   import trainer.view.NewHandContainer;
   
   public class TexpView extends Sprite implements Disposeable
   {
       
      
      private var _bg1:MovieImage;
      
      private var _bg2:Scale9CornerImage;
      
      private var _bg3:Scale9CornerImage;
      
      private var _bg4:Bitmap;
      
      private var _txtBg1:Bitmap;
      
      private var _bg5:MutipleImage;
      
      private var _texpCell:TexpCell;
      
      private var _lblTexpName:FilterFrameText;
      
      private var _lblCurrLv:FilterFrameText;
      
      private var _limitCount:FilterFrameText;
      
      private var _lblCurrEffect:FilterFrameText;
      
      private var _lblUpEffect:FilterFrameText;
      
      private var _txtCurrEffect:FilterFrameText;
      
      private var _txtUpEffect:FilterFrameText;
      
      private var _buyText:FilterFrameText;
      
      private var _buyText1:FilterFrameText;
      
      private var _sbtnGroup:SelectedButtonGroup;
      
      private var _sbtnAtt:SelectedButton;
      
      private var _sbtnHp:SelectedButton;
      
      private var _sbtnLuk:SelectedButton;
      
      private var _sbtnDef:SelectedButton;
      
      private var _sbtnSpd:SelectedButton;
      
      private var _sbtnMagicAtk:SelectedButton;
      
      private var _sbtnMagicDef:SelectedButton;
      
      private var _attLevel:FilterFrameText;
      
      private var _hpLevel:FilterFrameText;
      
      private var _lukLevel:FilterFrameText;
      
      private var _defLevel:FilterFrameText;
      
      private var _spdLevel:FilterFrameText;
      
      private var _magicAtkLevel:FilterFrameText;
      
      private var _magicDefLevel:FilterFrameText;
      
      private var _infoArray:Vector.<FilterFrameText>;
      
      private var _background1:Bitmap;
      
      private var _progressLevel:TexpLevelPro;
      
      private var _btnTexp:SimpleBitmapButton;
      
      private var _btnHelp:BaseButton;
      
      private var _btnBuy:TexpBuyButton;
      
      private var _textBack:Bitmap;
      
      private var _allInjectSCB:SelectedCheckButton;
      
      private var isActive:Boolean = false;
      
      public function TexpView()
      {
         super();
         initView();
         initEvent();
         texpGuide();
      }
      
      private function texpGuide() : void
      {
         if(!PlayerManager.Instance.Self.isNewOnceFinish(124))
         {
            if(PlayerManager.Instance.Self.Grade == 13 && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(7)))
            {
               NewHandContainer.Instance.showArrow(140,45,localToGlobal(new Point(347,235)),"asset.trainer.txtTexpGuide","guide.texp.txtPos",LayerManager.Instance.getLayerByType(2));
            }
         }
      }
      
      private function initView() : void
      {
         _infoArray = new Vector.<FilterFrameText>();
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("texpSystem.bg1");
         addChild(_bg1);
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("texpSystem.bg2");
         addChild(_bg2);
         _bg3 = ComponentFactory.Instance.creatComponentByStylename("texpSystem.bg3");
         addChild(_bg3);
         _bg4 = ComponentFactory.Instance.creatBitmap("asset.texpSystem.bg4");
         addChild(_bg4);
         _txtBg1 = ComponentFactory.Instance.creatBitmap("asset.texpSystem.txtBg1");
         PositionUtils.setPos(_txtBg1,"texpSystem.posTxtBg1");
         addChild(_txtBg1);
         _bg5 = ComponentFactory.Instance.creatComponentByStylename("texpSystem.bg5");
         addChild(_bg5);
         _background1 = ComponentFactory.Instance.creatBitmap("texpSystem.Background_Progress1");
         PositionUtils.setPos(_background1,"texpSystem.expBackground1Pos");
         addChild(_background1);
         _texpCell = ComponentFactory.Instance.creatCustomObject("texpSystem.texpCell");
         addChild(_texpCell);
         _textBack = ComponentFactory.Instance.creat("asset.texpSystem.texpNum");
         addChild(_textBack);
         _lblTexpName = ComponentFactory.Instance.creatComponentByStylename("texpSystem.lblTexpName");
         _lblTexpName.text = LanguageMgr.GetTranslation("texpSystem.view.TexpView.texpName");
         addChild(_lblTexpName);
         _lblCurrLv = ComponentFactory.Instance.creatComponentByStylename("texpSystem.lblCurrentLv");
         addChild(_lblCurrLv);
         _limitCount = ComponentFactory.Instance.creatComponentByStylename("texpSystem.lblCurrentLv");
         _limitCount.x = 242;
         _limitCount.y = 214;
         addChild(_limitCount);
         _lblCurrEffect = ComponentFactory.Instance.creatComponentByStylename("texpSystem.lblCurrentEffect");
         _lblCurrEffect.text = LanguageMgr.GetTranslation("texpSystem.view.TexpView.currEffect");
         addChild(_lblCurrEffect);
         _lblUpEffect = ComponentFactory.Instance.creatComponentByStylename("texpSystem.lblUpEffect");
         _lblUpEffect.text = LanguageMgr.GetTranslation("texpSystem.view.TexpView.upEffect");
         addChild(_lblUpEffect);
         _txtCurrEffect = ComponentFactory.Instance.creatComponentByStylename("texpSystem.txtCurrEffect");
         addChild(_txtCurrEffect);
         _txtUpEffect = ComponentFactory.Instance.creatComponentByStylename("texpSystem.txtUpEffect");
         addChild(_txtUpEffect);
         _sbtnGroup = new SelectedButtonGroup();
         _sbtnHp = ComponentFactory.Instance.creatComponentByStylename("texpSystem.hp");
         _sbtnHp.tipData = LanguageMgr.GetTranslation("texpSystem.view.TexpView.texpTip",TexpManager.Instance.getName(0));
         _sbtnGroup.addSelectItem(_sbtnHp);
         addChild(_sbtnHp);
         _hpLevel = ComponentFactory.Instance.creatComponentByStylename("texpSystem.hpLevel");
         addChild(_hpLevel);
         _infoArray.push(_hpLevel);
         _sbtnAtt = ComponentFactory.Instance.creatComponentByStylename("texpSystem.att");
         _sbtnAtt.tipData = LanguageMgr.GetTranslation("texpSystem.view.TexpView.texpTip",TexpManager.Instance.getName(1));
         _sbtnGroup.addSelectItem(_sbtnAtt);
         addChild(_sbtnAtt);
         _attLevel = ComponentFactory.Instance.creatComponentByStylename("texpSystem.attLevel");
         addChild(_attLevel);
         _infoArray.push(_attLevel);
         _sbtnDef = ComponentFactory.Instance.creatComponentByStylename("texpSystem.def");
         _sbtnDef.tipData = LanguageMgr.GetTranslation("texpSystem.view.TexpView.texpTip",TexpManager.Instance.getName(2));
         _sbtnGroup.addSelectItem(_sbtnDef);
         addChild(_sbtnDef);
         _defLevel = ComponentFactory.Instance.creatComponentByStylename("texpSystem.defLevel");
         addChild(_defLevel);
         _infoArray.push(_defLevel);
         _sbtnSpd = ComponentFactory.Instance.creatComponentByStylename("texpSystem.spd");
         _sbtnSpd.tipData = LanguageMgr.GetTranslation("texpSystem.view.TexpView.texpTip",TexpManager.Instance.getName(3));
         _sbtnGroup.addSelectItem(_sbtnSpd);
         addChild(_sbtnSpd);
         _spdLevel = ComponentFactory.Instance.creatComponentByStylename("texpSystem.spdLevel");
         addChild(_spdLevel);
         _infoArray.push(_spdLevel);
         _sbtnLuk = ComponentFactory.Instance.creatComponentByStylename("texpSystem.luk");
         _sbtnLuk.tipData = LanguageMgr.GetTranslation("texpSystem.view.TexpView.texpTip",TexpManager.Instance.getName(4));
         _sbtnGroup.addSelectItem(_sbtnLuk);
         addChild(_sbtnLuk);
         _lukLevel = ComponentFactory.Instance.creatComponentByStylename("texpSystem.lukLevel");
         addChild(_lukLevel);
         _infoArray.push(_lukLevel);
         _sbtnMagicAtk = ComponentFactory.Instance.creatComponentByStylename("texpSystem.magicAtk");
         _sbtnMagicAtk.tipData = LanguageMgr.GetTranslation("texpSystem.view.TexpView.texpTip",TexpManager.Instance.getName(5));
         _sbtnGroup.addSelectItem(_sbtnMagicAtk);
         addChild(_sbtnMagicAtk);
         _magicAtkLevel = ComponentFactory.Instance.creatComponentByStylename("texpSystem.magicAtkLevel");
         addChild(_magicAtkLevel);
         _infoArray.push(_magicAtkLevel);
         _sbtnMagicDef = ComponentFactory.Instance.creatComponentByStylename("texpSystem.magicDef");
         _sbtnMagicDef.tipData = LanguageMgr.GetTranslation("texpSystem.view.TexpView.texpTip",TexpManager.Instance.getName(6));
         _sbtnGroup.addSelectItem(_sbtnMagicDef);
         addChild(_sbtnMagicDef);
         _magicDefLevel = ComponentFactory.Instance.creatComponentByStylename("texpSystem.magicDefLevel");
         addChild(_magicDefLevel);
         _infoArray.push(_magicDefLevel);
         _btnTexp = ComponentFactory.Instance.creatComponentByStylename("texpSystem.btnTexp");
         addChild(_btnTexp);
         _btnBuy = ComponentFactory.Instance.creat("texpSystem.btnBuy");
         _btnBuy.setup(40003);
         addChild(_btnBuy);
         _buyText = ComponentFactory.Instance.creatComponentByStylename("ddttexpSystem.buyText");
         _buyText.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
         _btnBuy.addChild(_buyText);
         _btnHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"texpSystem.btnHelp",null,LanguageMgr.GetTranslation("texpSystem.view.TexpView.helpTitle"),"texpSystem.help.content",408,488);
         _progressLevel = ComponentFactory.Instance.creatComponentByStylename("TexpLevelProgress");
         addChild(_progressLevel);
         _progressLevel.tipStyle = "ddt.view.tips.OneLineTip";
         _progressLevel.tipDirctions = "3,7,6";
         _buyText1 = ComponentFactory.Instance.creatComponentByStylename("ddttexpSystem.buyText1");
         _buyText1.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
         _allInjectSCB = ComponentFactory.Instance.creatComponentByStylename("texpSystem.allInjectSCB");
         addChild(_allInjectSCB);
         _allInjectSCB.selected = true;
         setInfoLevel();
         _sbtnGroup.selectIndex = 1;
         setTexpInfo(_sbtnGroup.selectIndex);
         setLimitTxt();
      }
      
      private function setLimitTxt() : void
      {
         var _loc3_:int = 0;
         if(TexpManager.Instance.isXiuLianDaShi(PlayerManager.Instance.Self.buffInfo))
         {
            _loc3_ = 5;
         }
         else
         {
            _loc3_ = 0;
         }
         var _loc2_:int = PlayerManager.Instance.Self.Grade + _loc3_;
         var _loc1_:int = _loc2_ - PlayerManager.Instance.Self.texpCount;
         if(TexpManager.Instance.texpType == 53)
         {
            _loc1_ = _loc2_ - PlayerManager.Instance.Self.magicTexpCount;
         }
         var _loc4_:String = _loc1_ + "/" + _loc2_;
         _limitCount.text = _loc4_;
      }
      
      private function setInfoLevel() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc2_ = TexpManager.Instance.getInfo(_loc1_,TexpManager.Instance.getExp(_loc1_));
            _infoArray[_loc1_].text = LanguageMgr.GetTranslation("ddt.cardSystem.CardEquipView.levelText") + _loc2_.lv.toString();
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",__updateStoreBag);
         PlayerManager.Instance.Self.addEventListener("propertychange",playerPropertyEventHander);
         _sbtnGroup.addEventListener("change",__changeHandler);
         _sbtnAtt.addEventListener("click",__texpTypeClick);
         _sbtnHp.addEventListener("click",__texpTypeClick);
         _sbtnLuk.addEventListener("click",__texpTypeClick);
         _sbtnDef.addEventListener("click",__texpTypeClick);
         _sbtnSpd.addEventListener("click",__texpTypeClick);
         _sbtnMagicAtk.addEventListener("click",__texpTypeClick);
         _sbtnMagicDef.addEventListener("click",__texpTypeClick);
         _btnTexp.addEventListener("click",__texpClick);
         _btnBuy.addEventListener("click",__buyClick);
         _allInjectSCB.addEventListener("click",__allInjectSCBClick);
         TexpManager.Instance.addEventListener("texpHp",__onChange);
         TexpManager.Instance.addEventListener("texpAtt",__onChange);
         TexpManager.Instance.addEventListener("texpDef",__onChange);
         TexpManager.Instance.addEventListener("texpSpd",__onChange);
         TexpManager.Instance.addEventListener("texpLuk",__onChange);
         TexpManager.Instance.addEventListener("texpMagicAtk",__onChange);
         TexpManager.Instance.addEventListener("texpMagicDef",__onChange);
      }
      
      private function __isInjectSelectClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",__updateStoreBag);
         PlayerManager.Instance.Self.removeEventListener("propertychange",playerPropertyEventHander);
         _sbtnGroup.removeEventListener("change",__changeHandler);
         _sbtnAtt.removeEventListener("click",__texpTypeClick);
         _sbtnHp.removeEventListener("click",__texpTypeClick);
         _sbtnLuk.removeEventListener("click",__texpTypeClick);
         _sbtnDef.removeEventListener("click",__texpTypeClick);
         _sbtnSpd.removeEventListener("click",__texpTypeClick);
         _sbtnMagicAtk.removeEventListener("click",__texpTypeClick);
         _sbtnMagicDef.removeEventListener("click",__texpTypeClick);
         _btnTexp.removeEventListener("click",__texpClick);
         _btnBuy.removeEventListener("click",__buyClick);
         _allInjectSCB.removeEventListener("click",__allInjectSCBClick);
         TexpManager.Instance.removeEventListener("texpHp",__onChange);
         TexpManager.Instance.removeEventListener("texpAtt",__onChange);
         TexpManager.Instance.removeEventListener("texpDef",__onChange);
         TexpManager.Instance.removeEventListener("texpSpd",__onChange);
         TexpManager.Instance.removeEventListener("texpLuk",__onChange);
         TexpManager.Instance.removeEventListener("texpMagicAtk",__onChange);
         TexpManager.Instance.removeEventListener("texpMagicDef",__onChange);
      }
      
      private function __allInjectSCBClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function playerPropertyEventHander(param1:PlayerPropertyEvent) : void
      {
         setLimitTxt();
      }
      
      private function __buyBuff(param1:MouseEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc5_:Array = [];
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11907);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11908);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11909);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11910);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11911);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11912);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         _loc4_ = ShopManager.Instance.getGoodsByTemplateID(11913);
         _loc3_ = new ShopCarItemInfo(_loc4_.ShopID,_loc4_.TemplateID);
         ObjectUtils.copyProperties(_loc3_,_loc4_);
         _loc5_.push(_loc3_);
         var _loc2_:SetsShopView = new SetsShopView();
         _loc2_.initialize(_loc5_);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      public function clearInfo() : void
      {
         SocketManager.Instance.out.sendClearStoreBag();
         _texpCell.info = null;
      }
      
      public function startShine() : void
      {
         _texpCell.startShine();
      }
      
      public function stopShine() : void
      {
         _texpCell.stopShine();
      }
      
      private function __updateStoreBag(param1:BagEvent) : void
      {
         var _loc3_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1.changedSlots;
         for(_loc3_ in param1.changedSlots)
         {
            if(_loc3_ == 0)
            {
               _texpCell.info = PlayerManager.Instance.Self.StoreBag.items[0];
            }
         }
      }
      
      private function __onChange(param1:TexpEvent) : void
      {
         var _loc2_:* = param1.type;
         if("texpHp" !== _loc2_)
         {
            if("texpAtt" !== _loc2_)
            {
               if("texpDef" !== _loc2_)
               {
                  if("texpSpd" !== _loc2_)
                  {
                     if("texpLuk" !== _loc2_)
                     {
                        if("texpMagicAtk" !== _loc2_)
                        {
                           if("texpMagicDef" === _loc2_)
                           {
                              if(_sbtnGroup.selectIndex == 6)
                              {
                                 setTexpInfo(_sbtnGroup.selectIndex);
                              }
                           }
                        }
                     }
                     else if(_sbtnGroup.selectIndex == 4)
                     {
                        setTexpInfo(_sbtnGroup.selectIndex);
                     }
                     if(_sbtnGroup.selectIndex == 5)
                     {
                        setTexpInfo(_sbtnGroup.selectIndex);
                     }
                  }
                  else if(_sbtnGroup.selectIndex == 3)
                  {
                     setTexpInfo(_sbtnGroup.selectIndex);
                  }
               }
               else if(_sbtnGroup.selectIndex == 2)
               {
                  setTexpInfo(_sbtnGroup.selectIndex);
               }
            }
            else if(_sbtnGroup.selectIndex == 1)
            {
               setTexpInfo(_sbtnGroup.selectIndex);
            }
         }
         else if(_sbtnGroup.selectIndex == 0)
         {
            setTexpInfo(_sbtnGroup.selectIndex);
         }
      }
      
      private function __changeHandler(param1:Event) : void
      {
         setTexpInfo(_sbtnGroup.selectIndex);
      }
      
      private function __texpTypeClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
      }
      
      private function __texpClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         var _loc3_:InventoryItemInfo = _texpCell.info as InventoryItemInfo;
         if(_loc3_)
         {
            if(_loc3_.CategoryID == TexpManager.Instance.texpType)
            {
               _loc2_ = 0;
               if(TexpManager.Instance.isXiuLianDaShi(PlayerManager.Instance.Self.buffInfo))
               {
                  _loc2_ = 5;
               }
               else
               {
                  _loc2_ = 0;
               }
               if(TexpManager.Instance.texpType == 53)
               {
                  if(PlayerManager.Instance.Self.magicTexpCount >= PlayerManager.Instance.Self.Grade + _loc2_)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.magicTexpCountToplimit"));
                     return;
                  }
               }
               else if(PlayerManager.Instance.Self.texpCount >= PlayerManager.Instance.Self.Grade + _loc2_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.texpCountToplimit"));
                  return;
               }
               if(_sbtnGroup.selectIndex == -1)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.selectType"));
                  return;
               }
               if(TexpManager.Instance.getLv(TexpManager.Instance.getExp(_sbtnGroup.selectIndex)) >= PlayerManager.Instance.Self.Grade + 5)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TexpCell.lvToplimit"));
                  return;
               }
               SocketManager.Instance.out.sendTexp(_sbtnGroup.selectIndex,_loc3_.TemplateID,!!_allInjectSCB.selected?_loc3_.Count:1,_loc3_.Place);
               NewHandContainer.Instance.hideGuideCover();
               if(!PlayerManager.Instance.Self.isNewOnceFinish(124))
               {
                  NewHandContainer.Instance.clearArrowByID(140);
                  SocketManager.Instance.out.syncWeakStep(124);
               }
            }
            else
            {
               if(_loc3_.CategoryID == 53)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.texpTips"));
                  return;
               }
               if(_loc3_.CategoryID == 20)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.magicTexpTips"));
                  return;
               }
            }
         }
         else if(TexpManager.Instance.texpType == 53)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.magicTexpTips"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("texpSystem.view.TextCell.texpTips"));
         }
      }
      
      private function __buyClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         KeyboardShortcutsManager.Instance.prohibitNewHandBag(false);
         var _loc2_:NewShopBugleView = new NewShopMultiBugleView(6);
      }
      
      private function setTexpInfo(param1:int) : void
      {
         var _loc2_:TexpInfo = TexpManager.Instance.getInfo(param1,TexpManager.Instance.getExp(param1));
         _texpCell.texpInfo = _loc2_;
         _lblTexpName.text = TexpManager.Instance.getName(param1);
         _lblCurrLv.text = LanguageMgr.GetTranslation("ddt.cardSystem.CardEquipView.levelText") + _loc2_.lv.toString();
         _txtCurrEffect.text = _loc2_.currEffect.toString();
         _txtUpEffect.text = _loc2_.upEffect.toString();
         setInfoLevel();
         if(_loc2_.upExp != 0)
         {
            _progressLevel.setProgress(_loc2_.currExp / _loc2_.upExp * 100,100);
         }
         else
         {
            _progressLevel.setProgress(0,100);
         }
         _progressLevel.tipData = _loc2_.currExp + "/" + _loc2_.upExp;
         if(_loc2_.type == 5 || _loc2_.type == 6)
         {
            TexpManager.Instance.texpType = 53;
         }
         else
         {
            TexpManager.Instance.texpType = 20;
         }
         setLimitTxt();
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearInfo();
         ObjectUtils.disposeAllChildren(this);
         _bg1 = null;
         _bg2 = null;
         _bg3 = null;
         _bg4 = null;
         _bg5 = null;
         _txtBg1 = null;
         _texpCell = null;
         _lblTexpName = null;
         _lblCurrLv = null;
         _lblCurrEffect = null;
         _lblUpEffect = null;
         _txtCurrEffect = null;
         _txtUpEffect = null;
         _sbtnGroup = null;
         _sbtnAtt = null;
         _sbtnHp = null;
         _sbtnLuk = null;
         _sbtnDef = null;
         _sbtnSpd = null;
         _btnTexp = null;
         _btnBuy = null;
         _btnHelp = null;
         _attLevel = null;
         _hpLevel = null;
         _defLevel = null;
         _lukLevel = null;
         _spdLevel = null;
         _infoArray = null;
         _background1 = null;
         _progressLevel = null;
         _allInjectSCB = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
