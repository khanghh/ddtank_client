package horse.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.horse.HorseFrameRightBottomItemCell;
   import ddt.view.horse.HorseSkillCell;
   import ddtDeed.DeedManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getTimer;
   import horse.HorseManager;
   import horse.data.HorseEvent;
   import horse.data.HorseSkillExpVo;
   import horse.data.HorseSkillGetVo;
   import shop.manager.ShopBuyManager;
   
   public class HorseSkillUpFrame extends Sprite implements Disposeable
   {
       
      
      private var _levelTxt:FilterFrameText;
      
      private var _expBg:Bitmap;
      
      private var _expCover:Bitmap;
      
      private var _expPerTxt:FilterFrameText;
      
      private var _txtBg:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _upBtn:SimpleBitmapButton;
      
      private var _freeUpBtn:SimpleBitmapButton;
      
      private var _freeUpTxt:FilterFrameText;
      
      private var _curSkillCell:HorseSkillCell;
      
      private var _upCurSkillCell:HorseSkillCell;
      
      private var _upNextSkillCell:HorseSkillCell;
      
      private var _upCurSkillLevelTxt:FilterFrameText;
      
      private var _upNextSkillLevelTxt:FilterFrameText;
      
      private var _itemCell:HorseFrameRightBottomItemCell;
      
      private var _index:int;
      
      private var _skillExp:HorseSkillExpVo;
      
      private var _dataList:Vector.<HorseSkillGetVo>;
      
      private var _lastUpClickTime:int = 0;
      
      private var _maxCount:int;
      
      private var _itemCount:int;
      
      protected var _toLinkTxt:FilterFrameText;
      
      public function HorseSkillUpFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillUpFrame.levelTxt");
         _expBg = ComponentFactory.Instance.creatBitmap("asset.horse.upFrame.expBg");
         _expCover = ComponentFactory.Instance.creatBitmap("asset.horse.upFrame.expCover");
         _expPerTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.progressTxt");
         _expPerTxt.x = 17;
         _expPerTxt.y = 56;
         _txtBg = ComponentFactory.Instance.creatBitmap("asset.horse.upFrame.txtBg");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillUpFrame.countTxt");
         _countTxt.restrict = "0-9";
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("horse.upFrame.maxBtn");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("horse.upFrame.upBtn");
         _freeUpBtn = ComponentFactory.Instance.creatComponentByStylename("horse.upFrame.upBtn2");
         _freeUpTxt = ComponentFactory.Instance.creatComponentByStylename("horse.upFrame.upBtn2Txt");
         var bg:Bitmap = ComponentFactory.Instance.creatBitmap("asset.horse.frame.itemBg");
         _itemCell = new HorseFrameRightBottomItemCell(11165);
         PositionUtils.setPos(_itemCell,"horse.skillUpframe.itemCellPos");
         _upCurSkillLevelTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillUpFrame.levelTxt2");
         PositionUtils.setPos(_upCurSkillLevelTxt,"horse.skillUpFrame.upCurSkillLevelTxtPos");
         _upNextSkillLevelTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillUpFrame.levelTxt2");
         PositionUtils.setPos(_upNextSkillLevelTxt,"horse.skillUpFrame.upNextSkillLevelTxtPos");
         addChild(_levelTxt);
         addChild(_expBg);
         addChild(_expCover);
         _expCover.visible = false;
         addChild(_expPerTxt);
         addChild(_itemCell);
         addChild(_txtBg);
         addChild(_countTxt);
         addChild(_maxBtn);
         addChild(_upBtn);
         addChild(_upCurSkillLevelTxt);
         addChild(_upNextSkillLevelTxt);
         addChild(_freeUpBtn);
         addChild(_freeUpTxt);
         _toLinkTxt = ComponentFactory.Instance.creat("petAndHorse.risingStar.toLinkTxt");
         _toLinkTxt.mouseEnabled = true;
         _toLinkTxt.htmlText = LanguageMgr.GetTranslation("petAndHorse.risingStar.toLinkTxtValue");
         PositionUtils.setPos(_toLinkTxt,"petAndHorse.risingStar.toLinkTxtPos4");
         addChild(_toLinkTxt);
         _toLinkTxt.visible = false;
         refreshFreeTipTxt();
      }
      
      public function __show(e:HorseEvent) : void
      {
         var obj:Object = e.data;
         _index = obj.index;
         _skillExp = obj.curShowSkill;
         _dataList = obj.dataList;
         _expCover.visible = true;
         refreshView();
         calMaxCountUpAndItem();
         if(_itemCount > 0)
         {
            _countTxt.text = "1";
         }
         else
         {
            _countTxt.text = "0";
         }
      }
      
      private function refreshView(isReCell:Boolean = true) : void
      {
         var curExp:int = 0;
         var nextExp:int = 0;
         if(isReCell)
         {
            ObjectUtils.disposeObject(_curSkillCell);
            ObjectUtils.disposeObject(_upCurSkillCell);
            ObjectUtils.disposeObject(_upNextSkillCell);
            _curSkillCell = new HorseSkillCell(_skillExp.skillId);
            _curSkillCell.width = 71;
            _curSkillCell.height = 71;
            PositionUtils.setPos(_curSkillCell,"horse.skillUpframe.cellPos1");
            _upCurSkillCell = new HorseSkillCell(_dataList[_index].SkillID);
            PositionUtils.setPos(_upCurSkillCell,"horse.skillUpframe.cellPos2");
            if(_index >= _dataList.length - 1)
            {
               _upNextSkillCell = new HorseSkillCell(_dataList[_index].SkillID);
            }
            else
            {
               _upNextSkillCell = new HorseSkillCell(_dataList[_index + 1].SkillID);
            }
            PositionUtils.setPos(_upNextSkillCell,"horse.skillUpframe.cellPos3");
            addChild(_curSkillCell);
            addChild(_upCurSkillCell);
            addChild(_upNextSkillCell);
         }
         _levelTxt.text = LanguageMgr.GetTranslation("horse.skillUpFrame.levelTxt",_dataList[_index].Level);
         if(_index < _dataList.length - 1)
         {
            curExp = _skillExp.exp - _dataList[_index].Exp;
            nextExp = _dataList[_index + 1].Exp - _dataList[_index].Exp;
            _expCover.scaleX = curExp / nextExp;
            _expPerTxt.text = curExp + "/" + nextExp;
         }
         else
         {
            _expCover.scaleX = 1;
            _expPerTxt.text = "0/0";
         }
      }
      
      private function calMaxCountUpAndItem() : void
      {
         var curExp:int = 0;
         var nextExp:int = 0;
         var upExp:int = 0;
         if(_index < _dataList.length - 1)
         {
            curExp = _skillExp.exp - _dataList[_index].Exp;
            nextExp = _dataList[_index + 1].Exp - _dataList[_index].Exp;
            upExp = ItemManager.Instance.getTemplateById(11165).Property2;
            _maxCount = Math.ceil((nextExp - curExp) / upExp);
         }
         _itemCount = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11165);
      }
      
      private function initEvent() : void
      {
         HorseManager.instance.addEventListener("upHorseSkill",__show);
         addEventListener("response",__responseHandler);
         _upBtn.addEventListener("click",upClickHandler,false,0,true);
         _freeUpBtn.addEventListener("click",upClickHandler,false,0,true);
         _maxBtn.addEventListener("click",maxClickHandler,false,0,true);
         _countTxt.addEventListener("change",countTxtChangeHandler);
         HorseManager.instance.addEventListener("horseUpSkill",upSkillSucHandler);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",itemUpdateHandler);
         _toLinkTxt.addEventListener("link",__toLinkTxtHandler);
         DeedManager.instance.addEventListener("update_buff_data_event",refreshFreeTipTxt);
         DeedManager.instance.addEventListener("update_main_event",refreshFreeTipTxt);
      }
      
      private function refreshFreeTipTxt(event:Event = null) : void
      {
         var freeCount1:int = DeedManager.instance.getOneBuffData(13);
         if(freeCount1 > 0)
         {
            _freeUpBtn.visible = true;
            _freeUpTxt.visible = true;
            _freeUpTxt.text = "(" + freeCount1 + ")";
            _upBtn.visible = false;
         }
         else
         {
            _freeUpTxt.text = "(" + freeCount1 + ")";
            _freeUpBtn.visible = false;
            _freeUpTxt.visible = false;
            _upBtn.visible = true;
         }
      }
      
      private function itemUpdateHandler(event:BagEvent) : void
      {
         var curCount:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11165);
         if(_itemCount > curCount)
         {
            _countTxt.text = String(int(_countTxt.text) - (_itemCount - curCount));
         }
         _itemCount = curCount;
         countTxtChangeHandler(null);
      }
      
      private function upSkillSucHandler(event:Event) : void
      {
         var isReCell:Boolean = false;
         if(_skillExp.skillId != _dataList[_index].SkillID)
         {
            _index = Number(_index) + 1;
            isReCell = true;
         }
         refreshView(isReCell);
         calMaxCountUpAndItem();
      }
      
      private function countTxtChangeHandler(event:Event) : void
      {
         var inputCount:int = _countTxt.text;
         if(_itemCount > 0 && inputCount <= 0)
         {
            _countTxt.text = "1";
         }
         else if(inputCount > _itemCount)
         {
            _countTxt.text = _itemCount.toString();
         }
      }
      
      private function maxClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _countTxt.text = _maxCount.toString();
         countTxtChangeHandler(null);
      }
      
      private function upClickHandler(event:MouseEvent) : void
      {
         var confirmFrame:* = null;
         SoundManager.instance.play("008");
         if(_dataList == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillNull"));
            return;
         }
         if(_index >= _dataList.length - 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.skillCannotUp"));
            return;
         }
         if(getTimer() - _lastUpClickTime <= 1000)
         {
            return;
         }
         _lastUpClickTime = getTimer();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var freeCount1:int = DeedManager.instance.getOneBuffData(13);
         if(freeCount1 > 0)
         {
            SocketManager.Instance.out.sendHorseUpSkill(_skillExp.skillId,1);
            return;
         }
         if(int(_countTxt.text) <= 0)
         {
            confirmFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("horse.itemConfirmBuyPrompt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            confirmFrame.moveEnable = false;
            confirmFrame.addEventListener("response",buyConfirm,false,0,true);
            return;
         }
         var tmp:int = _countTxt.text;
         tmp = Math.min(tmp,_maxCount);
         SocketManager.Instance.out.sendHorseUpSkill(_skillExp.skillId,tmp);
      }
      
      private function buyConfirm(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",buyConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            ShopBuyManager.Instance.buy(11165,1,-1);
         }
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
         HorseManager.instance.removeEventListener("upHorseSkill",__show);
         removeEventListener("response",__responseHandler);
         _upBtn.removeEventListener("click",upClickHandler);
         _freeUpBtn.addEventListener("click",upClickHandler,false,0,true);
         _maxBtn.removeEventListener("click",maxClickHandler);
         _countTxt.removeEventListener("change",countTxtChangeHandler);
         HorseManager.instance.removeEventListener("horseUpSkill",upSkillSucHandler);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",itemUpdateHandler);
         _toLinkTxt.removeEventListener("link",__toLinkTxtHandler);
         DeedManager.instance.removeEventListener("update_buff_data_event",refreshFreeTipTxt);
         DeedManager.instance.removeEventListener("update_main_event",refreshFreeTipTxt);
      }
      
      private function __toLinkTxtHandler(evt:TextEvent) : void
      {
         SoundManager.instance.playButtonSound();
         StateManager.setState("dungeon");
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_expBg);
         _expBg = null;
         ObjectUtils.disposeObject(_expCover);
         _expCover = null;
         ObjectUtils.disposeObject(_expPerTxt);
         _expPerTxt = null;
         ObjectUtils.disposeObject(_txtBg);
         _txtBg = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_maxBtn);
         _maxBtn = null;
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         ObjectUtils.disposeObject(_curSkillCell);
         _curSkillCell = null;
         ObjectUtils.disposeObject(_upCurSkillCell);
         _upCurSkillCell = null;
         ObjectUtils.disposeObject(_upNextSkillCell);
         _upNextSkillCell = null;
         ObjectUtils.disposeObject(_upCurSkillLevelTxt);
         _upCurSkillLevelTxt = null;
         ObjectUtils.disposeObject(_upNextSkillLevelTxt);
         _upNextSkillLevelTxt = null;
         ObjectUtils.disposeObject(_itemCell);
         _itemCell = null;
         ObjectUtils.disposeObject(_skillExp);
         _skillExp = null;
         _dataList = null;
         ObjectUtils.disposeObject(_toLinkTxt);
         _toLinkTxt = null;
      }
   }
}
