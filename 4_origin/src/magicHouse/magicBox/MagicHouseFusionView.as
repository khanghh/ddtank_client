package magicHouse.magicBox
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.InviteManager;
   import magicHouse.MagicHouseManager;
   import magicHouse.MagicHouseModel;
   
   public class MagicHouseFusionView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _itemsContentBg:Bitmap;
      
      private var _fusionCellContentBg:Bitmap;
      
      private var _materialContentBg:Bitmap;
      
      private var _selfMoney:FilterFrameText;
      
      private var _selfElite:FilterFrameText;
      
      private var _itemCounts:FilterFrameText;
      
      private var _inputNumBg:Bitmap;
      
      private var _inputNumTxt:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _curNum:int;
      
      private var _maxNum:int;
      
      private var _needElite:FilterFrameText;
      
      private var _eliteCounts:FilterFrameText;
      
      private var _needMoney:FilterFrameText;
      
      private var _moneyCounts:FilterFrameText;
      
      private var _fusionCheckBtn:SelectedCheckButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _fusionBtn:SimpleBitmapButton;
      
      private var _helpFrame:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      private var _itemContents:VBox;
      
      private var _itemPanel:ScrollPanel;
      
      private var _itemInfoArr:Array;
      
      private var _itemArr:Array;
      
      private var _currentItem:MagicBoxFusionItem;
      
      private var _currentItemCell:BagCell;
      
      private var _materialArr:Array;
      
      private var _materialCountTxt1:FilterFrameText;
      
      private var _materialCountTxt2:FilterFrameText;
      
      private var _materialCountTxt3:FilterFrameText;
      
      private var _materialCountTxt4:FilterFrameText;
      
      private var _propBag:BagInfo;
      
      private var _isComposeEnable:Boolean = false;
      
      private var _fusionMc:MovieClip;
      
      private var _mashArea:MagicBoxMashArea;
      
      public function MagicHouseFusionView()
      {
         _propBag = PlayerManager.Instance.Self.getBag(1);
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.view.bg");
         PositionUtils.setPos(_bg,"magicHouse.magicbox.fusionviewbgPos");
         addChild(_bg);
         _itemsContentBg = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.itemcontent.bg");
         addChild(_itemsContentBg);
         _fusionCellContentBg = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.fusioncellcontent.bg");
         addChild(_fusionCellContentBg);
         _materialContentBg = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.materialcontent.bg");
         addChild(_materialContentBg);
         _loc3_ = 1;
         while(_loc3_ < 5)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("magichouse.magicbox.materialcellcontent.bg");
            PositionUtils.setPos(_loc2_,"magicbox.fusionview.materialcontentPos" + _loc3_);
            addChild(_loc2_);
            _loc3_++;
         }
         _selfMoney = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionView.selfmoneyTxt");
         addChild(_selfMoney);
         _selfMoney.text = PlayerManager.Instance.Self.Gold.toString();
         _selfElite = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionView.selfeliteTxt");
         addChild(_selfElite);
         _selfElite.text = PlayerManager.Instance.Self.essence + "";
         _itemCounts = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionView.itemcountsTxt");
         _itemCounts.text = LanguageMgr.GetTranslation("magichouse.magicboxView.fusionItemCounts");
         addChild(_itemCounts);
         _inputNumBg = ComponentFactory.Instance.creatBitmap("magichouse.magicboxview.fusionitem.inputBg");
         _inputNumTxt = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionview.inputTxt");
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionview.maxBtn");
         addChild(_inputNumBg);
         addChild(_inputNumTxt);
         addChild(_maxBtn);
         _needElite = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionView.needeliteTxt");
         _needElite.text = LanguageMgr.GetTranslation("magichouse.magicboxView.fusionNeedElite");
         addChild(_needElite);
         _eliteCounts = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionView.eliteTxt");
         addChild(_eliteCounts);
         _needMoney = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionView.needmoneyTxt");
         _needMoney.text = LanguageMgr.GetTranslation("magichouse.magicboxView.fusionNeedMoney");
         addChild(_needMoney);
         _moneyCounts = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionView.moneyTxt");
         addChild(_moneyCounts);
         _fusionCheckBtn = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionCheckBtn");
         _fusionCheckBtn.text = LanguageMgr.GetTranslation("magichouse.magicboxView.fusionCheckBtnTxt");
         addChild(_fusionCheckBtn);
         _fusionBtn = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusion.fusionBtn");
         addChild(_fusionBtn);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.helpBtn");
         PositionUtils.setPos(_helpBtn,"magicHouse.magicbox.helpbtnPos");
         addChild(_helpBtn);
         _itemInfoArr = MagicHouseModel.instance.itemFusionEnableList;
         _itemArr = [];
         _itemContents = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionview.leftitem.Vbox");
         _itemPanel = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionview.leftitemList");
         _itemPanel.setView(_itemContents);
         addChild(_itemPanel);
         _loc4_ = 0;
         while(_loc4_ < _itemInfoArr.length)
         {
            _loc1_ = new MagicBoxFusionItem();
            _itemContents.addChild(_loc1_);
            _loc1_.setItemData(_itemInfoArr[_loc4_]);
            _loc1_.buttonMode = true;
            _loc1_.addEventListener("click",__itemClickHandler);
            _itemArr.push(_loc1_);
            if(_loc4_ == 0)
            {
               _currentItem = _loc1_;
               _loc1_.setItemShine(true);
            }
            _loc4_++;
         }
         _itemPanel.invalidateViewport();
         _materialCountTxt1 = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionView.materialCountTxt1");
         _materialCountTxt2 = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionView.materialCountTxt2");
         _materialCountTxt3 = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionView.materialCountTxt3");
         _materialCountTxt4 = ComponentFactory.Instance.creatComponentByStylename("magicbox.fusionView.materialCountTxt4");
         addChild(_materialCountTxt1);
         addChild(_materialCountTxt2);
         addChild(_materialCountTxt3);
         addChild(_materialCountTxt4);
         _changeRightView();
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _itemArr;
         for each(var _loc2_ in _itemArr)
         {
            _loc2_.setItemShine(false);
         }
         _currentItem = param1.currentTarget as MagicBoxFusionItem;
         _currentItem.setItemShine(true);
         _changeRightView();
      }
      
      private function _changeRightView() : void
      {
         var _loc7_:int = 0;
         var _loc14_:* = null;
         var _loc16_:* = null;
         var _loc18_:int = 0;
         var _loc17_:* = null;
         var _loc15_:* = null;
         var _loc19_:int = 0;
         var _loc9_:* = null;
         var _loc13_:* = null;
         var _loc20_:int = 0;
         var _loc10_:* = null;
         var _loc12_:* = null;
         var _loc8_:int = 0;
         var _loc2_:int = -1;
         var _loc4_:int = -1;
         var _loc3_:int = -1;
         var _loc1_:int = -1;
         var _loc11_:int = -1;
         var _loc5_:int = -1;
         _curNum = 0;
         _maxNum = 9999;
         var _loc6_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(_currentItem.info.ItemID);
         if(_currentItemCell)
         {
            _currentItemCell.dispose();
         }
         _currentItemCell = new BagCell(0,_loc6_,true,ComponentFactory.Instance.creatBitmap("magichouse.magicboxview.fusionitemcell.bg"));
         addChild(_currentItemCell);
         var _loc21_:* = 70;
         _currentItemCell.height = _loc21_;
         _currentItemCell.width = _loc21_;
         PositionUtils.setPos(_currentItemCell,"magicbox.fusionview.fusionItemCellPos");
         if(!_materialArr)
         {
            _materialArr = [];
         }
         _loc7_ = 0;
         while(_loc7_ < _materialArr.length)
         {
            removeChild(_materialArr[0]);
            _materialArr.shift();
         }
         _loc21_ = "";
         _materialCountTxt4.text = _loc21_;
         _loc21_ = _loc21_;
         _materialCountTxt3.text = _loc21_;
         _loc21_ = _loc21_;
         _materialCountTxt2.text = _loc21_;
         _materialCountTxt1.text = _loc21_;
         if(_currentItem.info.Item1 > 0)
         {
            _loc14_ = ItemManager.Instance.getTemplateById(_currentItem.info.Item1);
            _loc16_ = new BagCell(0,_loc14_,true,ComponentFactory.Instance.creatBitmap("magichouse.magicboxview.fusionitemcell.bg"));
            PositionUtils.setPos(_loc16_,"magicbox.fusionview.materialcell1Pos");
            _loc21_ = 70;
            _loc16_.height = _loc21_;
            _loc16_.width = _loc21_;
            addChild(_loc16_);
            _loc18_ = _propBag.getItemCountByTemplateId(_currentItem.info.Item1);
            _loc2_ = _loc18_ / _currentItem.info.Item1Count;
            _materialArr.push(_loc16_);
            _materialCountTxt1.text = _loc18_ + "/" + _currentItem.info.Item1Count;
            removeChild(_materialCountTxt1);
            addChildAt(_materialCountTxt1,getChildIndex(_loc16_) + 1);
            if(_currentItem.info.Item2 > 0)
            {
               _loc17_ = ItemManager.Instance.getTemplateById(_currentItem.info.Item2);
               _loc15_ = new BagCell(0,_loc17_,true,ComponentFactory.Instance.creatBitmap("magichouse.magicboxview.fusionitemcell.bg"));
               PositionUtils.setPos(_loc15_,"magicbox.fusionview.materialcell2Pos");
               _loc21_ = 70;
               _loc15_.height = _loc21_;
               _loc15_.width = _loc21_;
               addChild(_loc15_);
               _loc19_ = _propBag.getItemCountByTemplateId(_currentItem.info.Item2);
               _loc4_ = _loc19_ / _currentItem.info.Item2Count;
               _materialArr.push(_loc15_);
               _materialCountTxt2.text = _loc19_ + "/" + _currentItem.info.Item2Count;
               removeChild(_materialCountTxt2);
               addChildAt(_materialCountTxt2,getChildIndex(_loc15_) + 1);
               if(_currentItem.info.Item3 > 0)
               {
                  _loc9_ = ItemManager.Instance.getTemplateById(_currentItem.info.Item3);
                  _loc13_ = new BagCell(0,_loc9_,true,ComponentFactory.Instance.creatBitmap("magichouse.magicboxview.fusionitemcell.bg"));
                  PositionUtils.setPos(_loc13_,"magicbox.fusionview.materialcell3Pos");
                  _loc21_ = 70;
                  _loc13_.height = _loc21_;
                  _loc13_.width = _loc21_;
                  addChild(_loc13_);
                  _loc20_ = _propBag.getItemCountByTemplateId(_currentItem.info.Item3);
                  _loc3_ = _loc20_ / _currentItem.info.Item3Count;
                  _materialArr.push(_loc13_);
                  _materialCountTxt3.text = _loc20_ + "/" + _currentItem.info.Item3Count;
                  removeChild(_materialCountTxt3);
                  addChildAt(_materialCountTxt3,getChildIndex(_loc13_) + 1);
                  if(_currentItem.info.Item4 > 0)
                  {
                     _loc10_ = ItemManager.Instance.getTemplateById(_currentItem.info.Item4);
                     _loc12_ = new BagCell(0,_loc10_,true,ComponentFactory.Instance.creatBitmap("magichouse.magicboxview.fusionitemcell.bg"));
                     PositionUtils.setPos(_loc12_,"magicbox.fusionview.materialcell4Pos");
                     _loc21_ = 70;
                     _loc12_.height = _loc21_;
                     _loc12_.width = _loc21_;
                     addChild(_loc12_);
                     _loc8_ = _propBag.getItemCountByTemplateId(_currentItem.info.Item4);
                     _loc1_ = _loc8_ / _currentItem.info.Item4Count;
                     _materialArr.push(_loc12_);
                     _materialCountTxt4.text = _loc8_ + "/" + _currentItem.info.Item4Count;
                     removeChild(_materialCountTxt4);
                     addChildAt(_materialCountTxt4,getChildIndex(_loc12_) + 1);
                  }
               }
            }
         }
         _loc11_ = PlayerManager.Instance.Self.Gold / _currentItem.info.NeedGold;
         _loc5_ = PlayerManager.Instance.Self.essence / _currentItem.info.NeedKey;
         if(_loc2_ != -1)
         {
            _maxNum = _loc2_;
         }
         else
         {
            _maxNum = _loc11_ > _loc5_?_loc5_:int(_loc11_);
         }
         if(_loc4_ != -1 && _loc4_ < _maxNum)
         {
            _maxNum = _loc4_;
         }
         if(_loc3_ != -1 && _loc3_ < _maxNum)
         {
            _maxNum = _loc3_;
         }
         if(_loc1_ != -1 && _loc1_ < _maxNum)
         {
            _maxNum = _loc1_;
         }
         _curNum = _maxNum > 0?1:0;
         _inputNumTxt.text = _curNum.toString();
         _eliteCounts.text = _currentItem.info.NeedKey.toString();
         _moneyCounts.text = _currentItem.info.NeedGold.toString();
      }
      
      private function initEvent() : void
      {
         MagicHouseManager.instance.addEventListener("magichouse_updata",__messageUpdate);
         MagicHouseManager.instance.addEventListener("magicbox_fusion_complete",__fusionComplete);
         _fusionBtn.addEventListener("click",__fusionClickHandler);
         _fusionCheckBtn.addEventListener("select",__fusionCheckHandler);
         _maxBtn.addEventListener("click",__maxHandler);
         _inputNumTxt.addEventListener("change",__inputTextChangeHandler);
         _helpBtn.addEventListener("click",__helpClick);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__updateBag);
      }
      
      private function removeEvent() : void
      {
         MagicHouseManager.instance.removeEventListener("magichouse_updata",__messageUpdate);
         MagicHouseManager.instance.removeEventListener("magicbox_fusion_complete",__fusionComplete);
         _fusionBtn.removeEventListener("click",__fusionClickHandler);
         _fusionCheckBtn.removeEventListener("select",__fusionCheckHandler);
         _maxBtn.removeEventListener("click",__maxHandler);
         _inputNumTxt.removeEventListener("change",__inputTextChangeHandler);
         _helpBtn.removeEventListener("click",__helpClick);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__updateBag);
      }
      
      private function __messageUpdate(param1:Event) : void
      {
         _selfElite.text = PlayerManager.Instance.Self.essence + "";
         _selfMoney.text = PlayerManager.Instance.Self.Gold.toString();
      }
      
      private function __fusionComplete(param1:Event) : void
      {
         _mashArea = new MagicBoxMashArea();
         LayerManager.Instance.addToLayer(_mashArea,2);
         PositionUtils.setPos(_mashArea,"magicbox.mashAreaPos");
         _mashArea.addEventListener("click",__mashAreaClickHandler);
         InviteManager.Instance.enabled = false;
         _changeRightView();
         _fusionMc = ComponentFactory.Instance.creat("magicbox.fusionComplete.mc");
         addChild(_fusionMc);
         _fusionMc.gotoAndPlay(1);
         _fusionMc.addEventListener("COMPLETE_FUSION",__fusionMcComplete);
      }
      
      private function __fusionMcComplete(param1:Event) : void
      {
         _mashArea.removeEventListener("click",__mashAreaClickHandler);
         if(_mashArea.parent)
         {
            _mashArea.parent.removeChild(_mashArea);
            _mashArea = null;
         }
         InviteManager.Instance.enabled = true;
         _fusionMc.removeEventListener("COMPLETE_FUSION",__fusionMcComplete);
         if(_fusionMc)
         {
            ObjectUtils.disposeObject(_fusionMc);
            _fusionMc = null;
         }
      }
      
      private function __mashAreaClickHandler(param1:MouseEvent) : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.magicboxView.inFusion"));
      }
      
      private function __fusionClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_canFusion())
         {
            SocketManager.Instance.out.magicboxFusion(_currentItem.info.ID,_curNum,_isComposeEnable);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.magicboxView.fusionFail"));
         }
      }
      
      private function _canFusion() : Boolean
      {
         var _loc9_:int = _currentItem.info.Item1Count;
         var _loc6_:int = _currentItem.info.Item2Count;
         var _loc8_:int = _currentItem.info.Item3Count;
         var _loc4_:int = _currentItem.info.Item4Count;
         var _loc5_:int = _loc9_ > 0?_propBag.getItemCountByTemplateId(_currentItem.info.Item1):_loc9_ - 1;
         var _loc3_:int = _loc6_ > 0?_propBag.getItemCountByTemplateId(_currentItem.info.Item2):_loc6_ - 1;
         var _loc12_:int = _loc8_ > 0?_propBag.getItemCountByTemplateId(_currentItem.info.Item3):_loc8_ - 1;
         var _loc11_:int = _loc4_ > 0?_propBag.getItemCountByTemplateId(_currentItem.info.Item4):_loc4_ - 1;
         var _loc2_:Number = PlayerManager.Instance.Self.essence;
         var _loc10_:int = _currentItem.info.NeedKey;
         var _loc7_:Number = PlayerManager.Instance.Self.Gold;
         var _loc1_:int = _currentItem.info.NeedGold;
         if(_loc2_ >= _loc10_ * _curNum && _loc7_ >= _loc1_ * _curNum && _curNum > 0)
         {
            return true;
         }
         return false;
      }
      
      private function __fusionCheckHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _isComposeEnable = _fusionCheckBtn.selected;
      }
      
      private function __maxHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _inputNumTxt.text = _maxNum.toString();
         _curNum = _maxNum;
      }
      
      private function __inputTextChangeHandler(param1:Event) : void
      {
         var _loc2_:int = _inputNumTxt.text;
         if(_loc2_ < 1)
         {
            _inputNumTxt.text = "0";
         }
         if(_loc2_ > _maxNum)
         {
            _inputNumTxt.text = _maxNum.toString();
         }
         _curNum = int(_inputNumTxt.text);
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_helpFrame)
         {
            _helpFrame = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.main");
            _helpFrame.titleText = LanguageMgr.GetTranslation("magichouse.magicboxView.fusiontxt");
            _helpFrame.addEventListener("response",__helpFrameRespose);
            _bgHelp = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.bgHelp");
            _content = ComponentFactory.Instance.creatCustomObject("magichouse.magicbox.help.content");
            _btnOk = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.btnOk");
            _btnOk.text = LanguageMgr.GetTranslation("ok");
            _btnOk.addEventListener("click",__closeHelpFrame);
            _helpFrame.addToContent(_bgHelp);
            _helpFrame.addToContent(_content);
            _helpFrame.addToContent(_btnOk);
         }
         LayerManager.Instance.addToLayer(_helpFrame,3,true,2);
      }
      
      private function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            _helpFrame.parent.removeChild(_helpFrame);
         }
      }
      
      private function __closeHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _helpFrame.parent.removeChild(_helpFrame);
      }
      
      private function __updateBag(param1:BagEvent) : void
      {
         _changeRightView();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_itemsContentBg)
         {
            ObjectUtils.disposeObject(_itemsContentBg);
         }
         _itemsContentBg = null;
         if(_fusionCellContentBg)
         {
            ObjectUtils.disposeObject(_fusionCellContentBg);
         }
         _fusionCellContentBg = null;
         if(_materialContentBg)
         {
            ObjectUtils.disposeObject(_materialContentBg);
         }
         _materialContentBg = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         if(_selfMoney)
         {
            ObjectUtils.disposeObject(_selfMoney);
         }
         _selfMoney = null;
         if(_selfElite)
         {
            ObjectUtils.disposeObject(_selfElite);
         }
         _selfElite = null;
         if(_itemCounts)
         {
            ObjectUtils.disposeObject(_itemCounts);
         }
         _itemCounts = null;
         if(_needElite)
         {
            ObjectUtils.disposeObject(_needElite);
         }
         _needElite = null;
         if(_eliteCounts)
         {
            ObjectUtils.disposeObject(_eliteCounts);
         }
         _eliteCounts = null;
         if(_needMoney)
         {
            ObjectUtils.disposeObject(_needMoney);
         }
         _needMoney = null;
         if(_moneyCounts)
         {
            ObjectUtils.disposeObject(_moneyCounts);
         }
         _moneyCounts = null;
         if(_fusionBtn)
         {
            ObjectUtils.disposeObject(_fusionBtn);
         }
         _fusionBtn = null;
         if(_itemPanel)
         {
            ObjectUtils.disposeObject(_itemPanel);
         }
         _itemPanel = null;
         if(_fusionCheckBtn)
         {
            ObjectUtils.disposeObject(_fusionCheckBtn);
         }
         _fusionCheckBtn = null;
         if(_inputNumBg)
         {
            ObjectUtils.disposeObject(_inputNumBg);
         }
         _inputNumBg = null;
         if(_inputNumTxt)
         {
            ObjectUtils.disposeObject(_inputNumTxt);
         }
         _inputNumTxt = null;
         if(_maxBtn)
         {
            ObjectUtils.disposeObject(_maxBtn);
         }
         _maxBtn = null;
         if(_fusionMc)
         {
            ObjectUtils.disposeObject(_fusionMc);
         }
         _fusionMc = null;
         if(_mashArea)
         {
            ObjectUtils.disposeObject(_mashArea);
         }
         _mashArea = null;
      }
   }
}
