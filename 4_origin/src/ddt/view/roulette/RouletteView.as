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
      
      public function RouletteView(templateIDList:Array)
      {
         _needKeyCount = [1,2,3,4,5,6,7,8,0];
         super();
         _templateIDList = templateIDList;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var bg:* = null;
         var cell:* = null;
         var goodsInfo:* = null;
         var info:* = null;
         var j:int = 0;
         var bgII:* = null;
         var selectCell:* = null;
         _turnControl = new TurnControl();
         _goodsList = new Vector.<RouletteGoodsCell>();
         _selectGoodsList = new Vector.<RouletteGoodsCell>();
         var _bg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.awardSystem.roulette.RouletteBG");
         addChild(_bg);
         var _bg2:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("roulette.BGI");
         addChild(_bg2);
         var _bg3:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("roulette.BGII");
         addChild(_bg3);
         var _bg4:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("roulette.cellBGIII");
         addChild(_bg4);
         var _bg5:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("roulette.cellBGV");
         addChild(_bg5);
         var _bg6:Bitmap = ComponentFactory.Instance.creatBitmap("asset.awardSystem.roulette.RouletteBGII");
         addChild(_bg6);
         var _bg7:Bitmap = ComponentFactory.Instance.creatBitmap("asset.awardSystem.roulette.tipBG");
         addChild(_bg7);
         var _bg8:Image = ComponentFactory.Instance.creatComponentByStylename("roulette.VIPicon1");
         addChild(_bg8);
         var _bg9:Image = ComponentFactory.Instance.creatComponentByStylename("roulette.VIPicon2");
         addChild(_bg9);
         var tiptxt1:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("roulette.RouletteTipI");
         tiptxt1.text = LanguageMgr.GetTranslation("roulette.tipTxt1");
         addChild(tiptxt1);
         var tiptxt2:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("roulette.RouletteTipII");
         tiptxt2.text = LanguageMgr.GetTranslation("roulette.tipTxt2");
         addChild(tiptxt2);
         var tiptxt3:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("roulette.RouletteTipIII");
         tiptxt3.text = LanguageMgr.GetTranslation("roulette.tipTxt3");
         addChild(tiptxt3);
         var tiptxt4:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("roulette.RouletteTipV");
         tiptxt4.text = LanguageMgr.GetTranslation("roulette.tipTxt4");
         addChild(tiptxt4);
         _keyConutText = ComponentFactory.Instance.creat("roulette.RouletteStyleI");
         _selectNumberText = ComponentFactory.Instance.creat("roulette.RouletteStyleII");
         _needKeyText = ComponentFactory.Instance.creat("roulette.RouletteStyleIII");
         addChild(_keyConutText);
         addChild(_selectNumberText);
         addChild(_needKeyText);
         getAllGoodsPoint();
         var _cellSprite:Sprite = ComponentFactory.Instance.creatCustomObject("roulette.cellSprite");
         addChild(_cellSprite);
         for(i = 0; i <= 17; )
         {
            bg = ComponentFactory.Instance.creatBitmap("asset.awardSystem.roulette.CellBGAsset");
            cell = new RouletteGoodsCell(bg,10,32);
            cell.addCellBg(ComponentFactory.Instance.creatComponentByStylename("roulette.cellBG"));
            cell.x = _pointArray[i].x;
            cell.y = _pointArray[i].y;
            cell.selected = true;
            _cellSprite.addChild(cell);
            goodsInfo = _templateIDList[i] as BoxGoodsTempInfo;
            info = getTemplateInfo(goodsInfo.TemplateId) as InventoryItemInfo;
            info.IsBinds = goodsInfo.IsBind;
            info.ValidDate = goodsInfo.ItemValid;
            info.IsJudge = true;
            cell.info = info;
            cell.count = goodsInfo.ItemCount;
            _goodsList.push(cell);
            i++;
         }
         _selectedCellBox = ComponentFactory.Instance.creat("roulette.SeletedHBox");
         _selectedCellBox.beginChanges();
         for(j = 0; j < 8; )
         {
            bgII = ComponentFactory.Instance.creatBitmap("asset.awardSystem.roulette.SelectCellBGAsset");
            selectCell = new RouletteGoodsCell(bgII,4,26);
            selectCell.addCellBg(ComponentFactory.Instance.creatComponentByStylename("roulette.cellBGII"));
            selectCell.selected = false;
            _selectGoodsList.push(selectCell);
            _selectedCellBox.addChild(selectCell);
            j++;
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
         var i:int = 0;
         var point:* = null;
         _pointArray = [];
         for(i = 0; i < 18; )
         {
            point = ComponentFactory.Instance.creatCustomObject("roulette.point" + i);
            _pointArray.push(point);
            i++;
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
      
      private function _getItem(e:PkgEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var templateID:int = 0;
         var itemType:int = 0;
         var timer:* = null;
         _itemList = new Vector.<RouletteGoodsCell>();
         _selectedGoodsInfoList = [];
         _selectedGoodsCountList = [];
         var pkg:PackageIn = e.pkg;
         var btlifeBoo:Boolean = pkg.readBoolean();
         if(btlifeBoo)
         {
            count = pkg.readInt();
            if(count > 1)
            {
               _type = count;
            }
            for(i = 0; i < count; )
            {
               templateID = pkg.readInt();
               itemType = pkg.readInt();
               _selectedGoodsInfo = getTemplateInfo(templateID) as InventoryItemInfo;
               _selectedGoodsInfo.StrengthenLevel = pkg.readInt();
               _selectedGoodsInfo.AttackCompose = pkg.readInt();
               _selectedGoodsInfo.DefendCompose = pkg.readInt();
               _selectedGoodsInfo.LuckCompose = pkg.readInt();
               _selectedGoodsInfo.AgilityCompose = pkg.readInt();
               _selectedGoodsInfo.IsBinds = pkg.readBoolean();
               _selectedGoodsInfo.ValidDate = pkg.readInt();
               _selectedCount = pkg.readByte();
               _selectedGoodsInfo.IsJudge = true;
               _selectedItemType = itemType;
               turnSlectedNumber = _findCellByItemID(templateID,_selectedCount);
               _selectedGoodsNumberInTemplateIDList = _findSelectedGoodsNumberInTemplateIDList(templateID,_selectedCount);
               _selectedGoodsInfoList.push(_selectedGoodsInfo);
               _selectedGoodsCountList.push(_selectedCount);
               i++;
            }
            if(count > 1)
            {
               _startButton.enable = false;
               _oneKeyStartBtn.enable = false;
               _isCanClose = false;
               timer = new Timer(500);
               timer.repeatCount = count;
               timer.start();
               timer.addEventListener("timer",timerHander);
               timer.addEventListener("timerComplete",timerCompHander);
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
      
      private function timerHander(e:TimerEvent) : void
      {
         _moveToSelctViewTimer(_index);
         _index = Number(_index) + 1;
      }
      
      private function timerCompHander(e:TimerEvent) : void
      {
         var timer:Timer = e.currentTarget as Timer;
         timer.start();
         _index = 0;
         _selectNumber = 0;
         timer.removeEventListener("timer",timerHander);
         timer.removeEventListener("timerComplete",timerCompHander);
         SoundManager.instance.play("125");
         _isCanClose = true;
      }
      
      private function _oneKeyClick(e:MouseEvent) : void
      {
         var type:int = 8 - _selectNumber;
         var total:int = totalKeyCount();
         sendStartRoulette(type);
         _selectNumberText.text = "0";
         _needKeyText.text = String(total);
      }
      
      private function _turnClick(e:MouseEvent) : void
      {
         sendStartRoulette(1);
         _needKeyText.text = _needKeyCount[_selectNumber];
         _selectNumberText.text = String(8 - _selectNumber);
      }
      
      private function sendStartRoulette(type:int = 0) : void
      {
         var total:int = 0;
         SoundManager.instance.play("008");
         if(!PlayerManager.Instance.Self.IsVIP)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.vip.vipIcon.notVip"));
            return;
         }
         _turnControl.autoMove = false;
         if(type > 1)
         {
            total = totalKeyCount();
            if(total <= keyCount && !isTurn)
            {
               isTurn = true;
               SocketManager.Instance.out.sendStartTurn(type);
            }
            else if(total > keyCount)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.vip.vipIcon.notVipCoin"));
            }
            return;
         }
         if(needKeyCount <= keyCount && !isTurn)
         {
            isTurn = true;
            SocketManager.Instance.out.sendStartTurn(type);
         }
         else if(needKeyCount > keyCount)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.vip.vipIcon.notVipCoin"));
         }
      }
      
      private function totalKeyCount() : int
      {
         var i:int = 0;
         var total:int = 0;
         for(i = _selectNumber; i < 8; )
         {
            total = total + _needKeyCount[i];
            i++;
         }
         return total;
      }
      
      private function _startTurn() : void
      {
         _startButton.enable = false;
         _oneKeyStartBtn.enable = false;
         _turnControl.turnPlate(_goodsList,turnSlectedNumber);
      }
      
      private function _buyKeyClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var i:int = _needKeyCount[_selectNumber] == 0?1:_needKeyCount[_selectNumber];
         RouletteManager.instance.showBuyRouletteKey(i);
      }
      
      private function _keyUpdate(e:RouletteEvent) : void
      {
         keyCount = e.keyCount;
      }
      
      private function _turnComplete(e:Event) : void
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
      
      private function _bigGlintComplete(e:Event) : void
      {
         _glintView.removeEventListener("bigGlintComplete",_bigGlintComplete);
         selectNumber = Number(selectNumber) + 1;
         isTurn = _selectNumber >= 8?true:false;
         SoundManager.instance.stop("063");
      }
      
      private function _moveToSelctViewTimer(index:int) : void
      {
         SoundManager.instance.play("135");
         _itemList[index].out();
         var cell:RouletteGoodsCell = _itemList[index] as RouletteGoodsCell;
         if(selectNumber < 8)
         {
            _selectGoodsList[selectNumber].info = _selectedGoodsInfoList[index];
            _selectGoodsList[selectNumber].count = _selectedGoodsCountList[index];
         }
         if(_type > 1)
         {
            _selectNumber = Number(_selectNumber) + 1;
         }
      }
      
      private function _moveToSelctView() : void
      {
         _goodsList[turnSlectedNumber].out();
         var cell:RouletteGoodsCell = _goodsList.splice(turnSlectedNumber,1)[0] as RouletteGoodsCell;
         if(selectNumber < 8)
         {
            _selectGoodsList[selectNumber].info = _selectedGoodsInfo;
            _selectGoodsList[selectNumber].count = _selectedCount;
         }
      }
      
      private function _findCellByItemID(itemId:int, _count:int) : int
      {
         var i:int = 0;
         for(i = 0; i < _goodsList.length; )
         {
            if(_goodsList[i].info.TemplateID == itemId && _goodsList[i].count == _count)
            {
               if(_type > 1)
               {
                  _itemList.push(_goodsList[i]);
                  _goodsList.splice(i,1);
               }
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function _findSelectedGoodsNumberInTemplateIDList(itemId:int, _count:int) : int
      {
         var i:int = 0;
         for(i = 0; i < _templateIDList.length; )
         {
            if(_templateIDList[i].TemplateId == itemId && _templateIDList[i].ItemCount == _count)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function _finish() : void
      {
         SocketManager.Instance.out.sendFinishRoulette();
      }
      
      public function set keyCount(value:int) : void
      {
         _keyCount = value;
         _keyConutText.text = String(_keyCount);
      }
      
      public function get keyCount() : int
      {
         return _keyCount;
      }
      
      public function set selectNumber(value:int) : void
      {
         _selectNumber = value;
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
      
      public function set turnSlectedNumber(value:int) : void
      {
         _turnSlectedNumber = value;
      }
      
      public function get turnSlectedNumber() : int
      {
         return _turnSlectedNumber;
      }
      
      public function set isTurn(value:Boolean) : void
      {
         _isTurn = value;
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
      
      private function getTemplateInfo(id:int) : InventoryItemInfo
      {
         var itemInfo:InventoryItemInfo = new InventoryItemInfo();
         itemInfo.TemplateID = id;
         ItemManager.fill(itemInfo);
         return itemInfo;
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var j:int = 0;
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
         for(i = 0; i < _goodsList.length; )
         {
            _goodsList[i].dispose();
            i++;
         }
         for(j = 0; j < _selectGoodsList.length; )
         {
            _selectGoodsList[j].dispose();
            j++;
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
