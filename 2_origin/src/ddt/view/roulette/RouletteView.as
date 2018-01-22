package ddt.view.roulette
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.RouletteManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import road7th.comm.PackageIn;
   
   public class RouletteView extends Sprite implements Disposeable
   {
      
      public static const GLINT_ALL_GOODSTYPE:int = 4;
      
      public static const SELECTGOODS_SUM:int = 8;
      
      public static const GLINT_ONE_TIME:int = 3100;
      
      public static const GLINT_ALL_TIME:int = 7500;
       
      
      private var _keyCount:int = 0;
      
      private var _turnControl:TurnControl;
      
      private var _startButton:BaseButton;
      
      private var _oneKeyStartBtn:BaseButton;
      
      private var _buyKeyButton:BaseButton;
      
      private var _pointArray:Array;
      
      private var _selectNumber:int = 0;
      
      private var _needKeyCount:Array;
      
      private var _goodsList:Vector.<RouletteGoodsCell>;
      
      private var _templateIDList:Array;
      
      private var _selectGoodsList:Vector.<RouletteGoodsCell>;
      
      private var _selectGoogsNumber:int = 0;
      
      private var _turnSlectedNumber:int = 0;
      
      private var _selectedGoodsInfo:InventoryItemInfo;
      
      private var _selectedGoodsNumberInTemplateIDList:int = 0;
      
      private var _isTurn:Boolean = false;
      
      private var _isCanClose:Boolean = true;
      
      private var _isLoadSucceed:Boolean = false;
      
      private var _winTimeOut:uint = 1;
      
      private var _glintView:RouletteGlintView;
      
      private var _selectedItemType:int;
      
      private var _selectedCount:int;
      
      private var _selectedCellBox:HBox;
      
      private var _keyConutText:FilterFrameText;
      
      private var _selectNumberText:FilterFrameText;
      
      private var _needKeyText:FilterFrameText;
      
      private var _itemList:Vector.<RouletteGoodsCell>;
      
      private var _type:int;
      
      private var _index:int;
      
      private var _selectedGoodsInfoList:Array;
      
      private var _selectedGoodsCountList:Array;
      
      public function RouletteView(param1:Array)
      {
         _needKeyCount = [1,2,3,4,5,6,7,8,0];
         super();
         _templateIDList = param1;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var _loc8_:int = 0;
         var _loc15_:* = null;
         var _loc5_:* = null;
         var _loc1_:* = null;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         var _loc21_:* = null;
         var _loc2_:* = null;
         _turnControl = new TurnControl();
         _goodsList = new Vector.<RouletteGoodsCell>();
         _selectGoodsList = new Vector.<RouletteGoodsCell>();
         var _loc19_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.awardSystem.roulette.RouletteBG");
         addChild(_loc19_);
         var _loc3_:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("roulette.BGI");
         addChild(_loc3_);
         var _loc4_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("roulette.BGII");
         addChild(_loc4_);
         var _loc18_:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("roulette.cellBGIII");
         addChild(_loc18_);
         var _loc17_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("roulette.cellBGV");
         addChild(_loc17_);
         var _loc16_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.awardSystem.roulette.RouletteBGII");
         addChild(_loc16_);
         var _loc14_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.awardSystem.roulette.tipBG");
         addChild(_loc14_);
         var _loc22_:Image = ComponentFactory.Instance.creatComponentByStylename("roulette.VIPicon1");
         addChild(_loc22_);
         var _loc20_:Image = ComponentFactory.Instance.creatComponentByStylename("roulette.VIPicon2");
         addChild(_loc20_);
         var _loc11_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("roulette.RouletteTipI");
         _loc11_.text = LanguageMgr.GetTranslation("roulette.tipTxt1");
         addChild(_loc11_);
         var _loc9_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("roulette.RouletteTipII");
         _loc9_.text = LanguageMgr.GetTranslation("roulette.tipTxt2");
         addChild(_loc9_);
         var _loc13_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("roulette.RouletteTipIII");
         _loc13_.text = LanguageMgr.GetTranslation("roulette.tipTxt3");
         addChild(_loc13_);
         var _loc12_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("roulette.RouletteTipV");
         _loc12_.text = LanguageMgr.GetTranslation("roulette.tipTxt4");
         addChild(_loc12_);
         _keyConutText = ComponentFactory.Instance.creat("roulette.RouletteStyleI");
         _selectNumberText = ComponentFactory.Instance.creat("roulette.RouletteStyleII");
         _needKeyText = ComponentFactory.Instance.creat("roulette.RouletteStyleIII");
         addChild(_keyConutText);
         addChild(_selectNumberText);
         addChild(_needKeyText);
         getAllGoodsPoint();
         var _loc10_:Sprite = ComponentFactory.Instance.creatCustomObject("roulette.cellSprite");
         addChild(_loc10_);
         _loc8_ = 0;
         while(_loc8_ <= 17)
         {
            _loc15_ = ComponentFactory.Instance.creatBitmap("asset.awardSystem.roulette.CellBGAsset");
            _loc5_ = new RouletteGoodsCell(_loc15_,10,32);
            _loc5_.addCellBg(ComponentFactory.Instance.creatComponentByStylename("roulette.cellBG"));
            _loc5_.x = _pointArray[_loc8_].x;
            _loc5_.y = _pointArray[_loc8_].y;
            _loc5_.selected = true;
            _loc10_.addChild(_loc5_);
            _loc1_ = _templateIDList[_loc8_] as BoxGoodsTempInfo;
            _loc7_ = getTemplateInfo(_loc1_.TemplateId) as InventoryItemInfo;
            _loc7_.IsBinds = _loc1_.IsBind;
            _loc7_.ValidDate = _loc1_.ItemValid;
            _loc7_.IsJudge = true;
            _loc5_.info = _loc7_;
            _loc5_.count = _loc1_.ItemCount;
            _goodsList.push(_loc5_);
            _loc8_++;
         }
         _selectedCellBox = ComponentFactory.Instance.creat("roulette.SeletedHBox");
         _selectedCellBox.beginChanges();
         _loc6_ = 0;
         while(_loc6_ < 8)
         {
            _loc21_ = ComponentFactory.Instance.creatBitmap("asset.awardSystem.roulette.SelectCellBGAsset");
            _loc2_ = new RouletteGoodsCell(_loc21_,4,26);
            _loc2_.addCellBg(ComponentFactory.Instance.creatComponentByStylename("roulette.cellBGII"));
            _loc2_.selected = false;
            _selectGoodsList.push(_loc2_);
            _selectedCellBox.addChild(_loc2_);
            _loc6_++;
         }
         _selectedCellBox.commitChanges();
         addChild(_selectedCellBox);
         selectNumber = 0;
         _startButton = ComponentFactory.Instance.creat("roulette.StartTurnButton");
         addChild(_startButton);
         _oneKeyStartBtn = ComponentFactory.Instance.creat("roulette.StartOneKeyButton");
         addChild(_oneKeyStartBtn);
         _buyKeyButton = ComponentFactory.Instance.creat("roulette.BuyKeyButton");
         addChild(_buyKeyButton);
         _buyKeyButton.visible = false;
         _glintView = new RouletteGlintView(_pointArray);
         addChild(_glintView);
         _turnControl.turnPlateII(_goodsList);
      }
      
      private function getAllGoodsPoint() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _pointArray = [];
         _loc2_ = 0;
         while(_loc2_ < 18)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("roulette.point" + _loc2_);
            _pointArray.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(30),_getItem);
         RouletteManager.instance.addEventListener("roulette_key_count_update",_keyUpdate);
         _turnControl.addEventListener("turn_complete",_turnComplete);
         _startButton.addEventListener("click",_turnClick);
         _oneKeyStartBtn.addEventListener("click",_oneKeyClick);
         _buyKeyButton.addEventListener("click",_buyKeyClick);
      }
      
      private function _getItem(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _itemList = new Vector.<RouletteGoodsCell>();
         _selectedGoodsInfoList = [];
         _selectedGoodsCountList = [];
         var _loc6_:PackageIn = param1.pkg;
         var _loc7_:Boolean = _loc6_.readBoolean();
         if(_loc7_)
         {
            _loc3_ = _loc6_.readInt();
            if(_loc3_ > 1)
            {
               _type = _loc3_;
            }
            _loc8_ = 0;
            while(_loc8_ < _loc3_)
            {
               _loc2_ = _loc6_.readInt();
               _loc5_ = _loc6_.readInt();
               _selectedGoodsInfo = getTemplateInfo(_loc2_) as InventoryItemInfo;
               _selectedGoodsInfo.StrengthenLevel = _loc6_.readInt();
               _selectedGoodsInfo.AttackCompose = _loc6_.readInt();
               _selectedGoodsInfo.DefendCompose = _loc6_.readInt();
               _selectedGoodsInfo.LuckCompose = _loc6_.readInt();
               _selectedGoodsInfo.AgilityCompose = _loc6_.readInt();
               _selectedGoodsInfo.IsBinds = _loc6_.readBoolean();
               _selectedGoodsInfo.ValidDate = _loc6_.readInt();
               _selectedCount = _loc6_.readByte();
               _selectedGoodsInfo.IsJudge = true;
               _selectedItemType = _loc5_;
               turnSlectedNumber = _findCellByItemID(_loc2_,_selectedCount);
               _selectedGoodsNumberInTemplateIDList = _findSelectedGoodsNumberInTemplateIDList(_loc2_,_selectedCount);
               _selectedGoodsInfoList.push(_selectedGoodsInfo);
               _selectedGoodsCountList.push(_selectedCount);
               _loc8_++;
            }
            if(_loc3_ > 1)
            {
               _startButton.enable = false;
               _oneKeyStartBtn.enable = false;
               _isCanClose = false;
               _loc4_ = new Timer(500);
               _loc4_.repeatCount = _loc3_;
               _loc4_.start();
               _loc4_.addEventListener("timer",timerHander);
               _loc4_.addEventListener("timerComplete",timerCompHander);
               return;
            }
            if(turnSlectedNumber == -1)
            {
               isTurn = false;
            }
            else
            {
               _startTurn();
               _isCanClose = false;
            }
         }
         else
         {
            isTurn = false;
            _turnControl.autoMove = true;
         }
      }
      
      private function timerHander(param1:TimerEvent) : void
      {
         _moveToSelctViewTimer(_index);
         _index = Number(_index) + 1;
      }
      
      private function timerCompHander(param1:TimerEvent) : void
      {
         var _loc2_:Timer = param1.currentTarget as Timer;
         _loc2_.start();
         _index = 0;
         _selectNumber = 0;
         _loc2_.removeEventListener("timer",timerHander);
         _loc2_.removeEventListener("timerComplete",timerCompHander);
         SoundManager.instance.play("125");
         _isCanClose = true;
      }
      
      private function _oneKeyClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 8 - _selectNumber;
         var _loc2_:int = totalKeyCount();
         sendStartRoulette(_loc3_);
         _selectNumberText.text = "0";
         _needKeyText.text = String(_loc2_);
      }
      
      private function _turnClick(param1:MouseEvent) : void
      {
         sendStartRoulette(1);
         _needKeyText.text = _needKeyCount[_selectNumber];
         _selectNumberText.text = String(8 - _selectNumber);
      }
      
      private function sendStartRoulette(param1:int = 0) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         if(!PlayerManager.Instance.Self.IsVIP)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.vip.vipIcon.notVip"));
            return;
         }
         _turnControl.autoMove = false;
         if(param1 > 1)
         {
            _loc2_ = totalKeyCount();
            if(_loc2_ <= keyCount && !isTurn)
            {
               isTurn = true;
               SocketManager.Instance.out.sendStartTurn(param1);
            }
            else if(_loc2_ > keyCount)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.vip.vipIcon.notVipCoin"));
            }
            return;
         }
         if(needKeyCount <= keyCount && !isTurn)
         {
            isTurn = true;
            SocketManager.Instance.out.sendStartTurn(param1);
         }
         else if(needKeyCount > keyCount)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.vip.vipIcon.notVipCoin"));
         }
      }
      
      private function totalKeyCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = _selectNumber;
         while(_loc2_ < 8)
         {
            _loc1_ = _loc1_ + _needKeyCount[_loc2_];
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function _startTurn() : void
      {
         _startButton.enable = false;
         _oneKeyStartBtn.enable = false;
         _turnControl.turnPlate(_goodsList,turnSlectedNumber);
      }
      
      private function _buyKeyClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:int = _needKeyCount[_selectNumber] == 0?1:_needKeyCount[_selectNumber];
         RouletteManager.instance.showBuyRouletteKey(_loc2_);
      }
      
      private function _keyUpdate(param1:RouletteEvent) : void
      {
         keyCount = param1.keyCount;
      }
      
      private function _turnComplete(param1:Event) : void
      {
         _startButton.enable = true;
         _oneKeyStartBtn.enable = true;
         _goodsList[turnSlectedNumber].selected = false;
         _winTimeOut = setTimeout(_updateTurnList,3100);
         _glintView.showOneCell(_selectedGoodsNumberInTemplateIDList,3100);
         SoundManager.instance.play("126");
      }
      
      private function _updateTurnList() : void
      {
         _moveToSelctView();
         SoundManager.instance.play("125");
         _isCanClose = true;
         if(_selectedItemType >= 4)
         {
            _glintView.showTwoStep(7500);
            SoundManager.instance.play("063");
            _glintView.addEventListener("bigGlintComplete",_bigGlintComplete);
         }
         else
         {
            selectNumber = Number(selectNumber) + 1;
            isTurn = _selectNumber >= 8?true:false;
         }
      }
      
      private function _bigGlintComplete(param1:Event) : void
      {
         _glintView.removeEventListener("bigGlintComplete",_bigGlintComplete);
         selectNumber = Number(selectNumber) + 1;
         isTurn = _selectNumber >= 8?true:false;
         SoundManager.instance.stop("063");
      }
      
      private function _moveToSelctViewTimer(param1:int) : void
      {
         SoundManager.instance.play("135");
         _itemList[param1].out();
         var _loc2_:RouletteGoodsCell = _itemList[param1] as RouletteGoodsCell;
         if(selectNumber < 8)
         {
            _selectGoodsList[selectNumber].info = _selectedGoodsInfoList[param1];
            _selectGoodsList[selectNumber].count = _selectedGoodsCountList[param1];
         }
         if(_type > 1)
         {
            _selectNumber = Number(_selectNumber) + 1;
         }
      }
      
      private function _moveToSelctView() : void
      {
         _goodsList[turnSlectedNumber].out();
         var _loc1_:RouletteGoodsCell = _goodsList.splice(turnSlectedNumber,1)[0] as RouletteGoodsCell;
         if(selectNumber < 8)
         {
            _selectGoodsList[selectNumber].info = _selectedGoodsInfo;
            _selectGoodsList[selectNumber].count = _selectedCount;
         }
      }
      
      private function _findCellByItemID(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _goodsList.length)
         {
            if(_goodsList[_loc3_].info.TemplateID == param1 && _goodsList[_loc3_].count == param2)
            {
               if(_type > 1)
               {
                  _itemList.push(_goodsList[_loc3_]);
                  _goodsList.splice(_loc3_,1);
               }
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function _findSelectedGoodsNumberInTemplateIDList(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _templateIDList.length)
         {
            if(_templateIDList[_loc3_].TemplateId == param1 && _templateIDList[_loc3_].ItemCount == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function _finish() : void
      {
         SocketManager.Instance.out.sendFinishRoulette();
      }
      
      public function set keyCount(param1:int) : void
      {
         _keyCount = param1;
         _keyConutText.text = String(_keyCount);
      }
      
      public function get keyCount() : int
      {
         return _keyCount;
      }
      
      public function set selectNumber(param1:int) : void
      {
         _selectNumber = param1;
         _selectNumberText.text = String(8 - _selectNumber);
         _needKeyText.text = String(_needKeyCount[_selectNumber]);
         if(_selectNumber == 8)
         {
            _startButton.enable = false;
            _oneKeyStartBtn.enable = false;
         }
      }
      
      private function get needKeyCount() : int
      {
         return _needKeyCount[_selectNumber];
      }
      
      public function get selectNumber() : int
      {
         return _selectNumber;
      }
      
      public function set turnSlectedNumber(param1:int) : void
      {
         _turnSlectedNumber = param1;
      }
      
      public function get turnSlectedNumber() : int
      {
         return _turnSlectedNumber;
      }
      
      public function set isTurn(param1:Boolean) : void
      {
         _isTurn = param1;
         if(_isTurn)
         {
            _buyKeyButton.enable = false;
         }
         else
         {
            _buyKeyButton.enable = true;
         }
      }
      
      public function get isTurn() : Boolean
      {
         return _isTurn;
      }
      
      public function get isCanClose() : Boolean
      {
         return _isCanClose;
      }
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         ItemManager.fill(_loc2_);
         return _loc2_;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         RouletteManager.instance.removeEventListener("roulette_key_count_update",_keyUpdate);
         SocketManager.Instance.removeEventListener(PkgEvent.format(30),_getItem);
         _turnControl.removeEventListener("turn_complete",_turnComplete);
         _startButton.removeEventListener("click",_turnClick);
         _buyKeyButton.removeEventListener("click",_buyKeyClick);
         _oneKeyStartBtn.removeEventListener("click",_oneKeyClick);
         _selectedGoodsInfo = null;
         if(_turnControl)
         {
            _turnControl.dispose();
            _turnControl = null;
         }
         if(_glintView)
         {
            _glintView.removeEventListener("bigGlintComplete",_bigGlintComplete);
            _glintView.dispose();
            _glintView = null;
         }
         _finish();
         _templateIDList.splice(0,_templateIDList.length);
         clearTimeout(_winTimeOut);
         _loc2_ = 0;
         while(_loc2_ < _goodsList.length)
         {
            _goodsList[_loc2_].dispose();
            _loc2_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _selectGoodsList.length)
         {
            _selectGoodsList[_loc1_].dispose();
            _loc1_++;
         }
         if(_startButton)
         {
            ObjectUtils.disposeObject(_startButton);
         }
         _startButton = null;
         ObjectUtils.disposeObject(_oneKeyStartBtn);
         if(_buyKeyButton)
         {
            ObjectUtils.disposeObject(_buyKeyButton);
         }
         _buyKeyButton = null;
         if(_keyConutText)
         {
            ObjectUtils.disposeObject(_keyConutText);
         }
         _keyConutText = null;
         if(_selectNumberText)
         {
            ObjectUtils.disposeObject(_selectNumberText);
         }
         _selectNumberText = null;
         if(_needKeyText)
         {
            ObjectUtils.disposeObject(_needKeyText);
         }
         _needKeyText = null;
         if(_selectedCellBox)
         {
            ObjectUtils.disposeObject(_selectedCellBox);
         }
         _selectedCellBox = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
