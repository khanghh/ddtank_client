package horse.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
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
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getTimer;
   import horse.HorseManager;
   import horse.data.HorseSkillExpVo;
   import horse.data.HorseSkillGetVo;
   import shop.manager.ShopBuyManager;
   
   public class HorseSkillUpFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _expBg:Bitmap;
      
      private var _expCover:Bitmap;
      
      private var _expPerTxt:FilterFrameText;
      
      private var _rightArrow:Bitmap;
      
      private var _countTitleTxt:FilterFrameText;
      
      private var _txtBg:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      private var _maxBtn:SimpleBitmapButton;
      
      private var _upBtn:SimpleBitmapButton;
      
      private var _freeUpBtn:SimpleBitmapButton;
      
      private var _freeUpTxt:FilterFrameText;
      
      private var _curSkillCell:HorseSkillCell;
      
      private var _upCurSkillCell:HorseSkillCell;
      
      private var _upNextSkillCell:HorseSkillCell;
      
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
         titleText = LanguageMgr.GetTranslation("horse.skillUpFrame.titleTxt");
         _bg = ComponentFactory.Instance.creatBitmap("asset.horse.upFrame.bg");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillUpFrame.levelTxt");
         _expBg = ComponentFactory.Instance.creatBitmap("asset.horse.upFrame.expBg");
         _expCover = ComponentFactory.Instance.creatBitmap("asset.horse.upFrame.expCover");
         _expPerTxt = ComponentFactory.Instance.creatComponentByStylename("horse.frame.progressTxt");
         _expPerTxt.x = 57;
         _expPerTxt.y = 39;
         _rightArrow = ComponentFactory.Instance.creatBitmap("asset.horse.upFrame.rightArrow");
         _countTitleTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillUpFrame.countTitleTxt");
         _countTitleTxt.text = LanguageMgr.GetTranslation("horse.skillUpFrame.countTitleTxt");
         _txtBg = ComponentFactory.Instance.creatBitmap("asset.horse.upFrame.txtBg");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("horse.skillUpFrame.countTxt");
         _countTxt.restrict = "0-9";
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("horse.upFrame.maxBtn");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("horse.upFrame.upBtn");
         _freeUpBtn = ComponentFactory.Instance.creatComponentByStylename("horse.upFrame.upBtn2");
         _freeUpTxt = ComponentFactory.Instance.creatComponentByStylename("horse.upFrame.upBtn2Txt");
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.horse.frame.itemBg");
         _itemCell = new HorseFrameRightBottomItemCell(11165);
         PositionUtils.setPos(_itemCell,"horse.skillUpframe.itemCellPos");
         addToContent(_bg);
         addToContent(_levelTxt);
         addToContent(_expBg);
         addToContent(_expCover);
         addToContent(_expPerTxt);
         addToContent(_rightArrow);
         addToContent(_itemCell);
         addToContent(_countTitleTxt);
         addToContent(_txtBg);
         addToContent(_countTxt);
         addToContent(_maxBtn);
         addToContent(_upBtn);
         addToContent(_freeUpBtn);
         addToContent(_freeUpTxt);
         _toLinkTxt = ComponentFactory.Instance.creat("petAndHorse.risingStar.toLinkTxt");
         _toLinkTxt.mouseEnabled = true;
         _toLinkTxt.htmlText = LanguageMgr.GetTranslation("petAndHorse.risingStar.toLinkTxtValue");
         PositionUtils.setPos(_toLinkTxt,"petAndHorse.risingStar.toLinkTxtPos4");
         addToContent(_toLinkTxt);
         _toLinkTxt.visible = false;
         refreshFreeTipTxt();
      }
      
      public function show(param1:int, param2:HorseSkillExpVo, param3:Vector.<HorseSkillGetVo>) : void
      {
         _index = param1;
         _skillExp = param2;
         _dataList = param3;
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
      
      private function refreshView(param1:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(param1)
         {
            ObjectUtils.disposeObject(_curSkillCell);
            ObjectUtils.disposeObject(_upCurSkillCell);
            ObjectUtils.disposeObject(_upNextSkillCell);
            _curSkillCell = new HorseSkillCell(_skillExp.skillId);
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
            addToContent(_curSkillCell);
            addToContent(_upCurSkillCell);
            addToContent(_upNextSkillCell);
         }
         _levelTxt.text = LanguageMgr.GetTranslation("horse.skillUpFrame.levelTxt",_dataList[_index].Level);
         if(_index < _dataList.length - 1)
         {
            _loc3_ = _skillExp.exp - _dataList[_index].Exp;
            _loc2_ = _dataList[_index + 1].Exp - _dataList[_index].Exp;
            _expCover.scaleX = _loc3_ / _loc2_;
            _expPerTxt.text = _loc3_ + "/" + _loc2_;
         }
         else
         {
            _expCover.scaleX = 1;
            _expPerTxt.text = "0/0";
         }
      }
      
      private function calMaxCountUpAndItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(_index < _dataList.length - 1)
         {
            _loc2_ = _skillExp.exp - _dataList[_index].Exp;
            _loc1_ = _dataList[_index + 1].Exp - _dataList[_index].Exp;
            _loc3_ = ItemManager.Instance.getTemplateById(11165).Property2;
            _maxCount = Math.ceil((_loc1_ - _loc2_) / _loc3_);
         }
         _itemCount = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11165);
      }
      
      private function initEvent() : void
      {
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
      
      private function refreshFreeTipTxt(param1:Event = null) : void
      {
         var _loc2_:int = DeedManager.instance.getOneBuffData(13);
         if(_loc2_ > 0)
         {
            _freeUpBtn.visible = true;
            _freeUpTxt.visible = true;
            _freeUpTxt.text = "(" + _loc2_ + ")";
            _upBtn.visible = false;
         }
         else
         {
            _freeUpTxt.text = "(" + _loc2_ + ")";
            _freeUpBtn.visible = false;
            _freeUpTxt.visible = false;
            _upBtn.visible = true;
         }
      }
      
      private function itemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(11165);
         if(_itemCount > _loc2_)
         {
            _countTxt.text = String(int(_countTxt.text) - (_itemCount - _loc2_));
         }
         _itemCount = _loc2_;
         countTxtChangeHandler(null);
      }
      
      private function upSkillSucHandler(param1:Event) : void
      {
         var _loc2_:Boolean = false;
         if(_skillExp.skillId != _dataList[_index].SkillID)
         {
            _index = Number(_index) + 1;
            _loc2_ = true;
         }
         refreshView(_loc2_);
         calMaxCountUpAndItem();
      }
      
      private function countTxtChangeHandler(param1:Event) : void
      {
         var _loc2_:int = _countTxt.text;
         if(_itemCount > 0 && _loc2_ <= 0)
         {
            _countTxt.text = "1";
         }
         else if(_loc2_ > _itemCount)
         {
            _countTxt.text = _itemCount.toString();
         }
      }
      
      private function maxClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _countTxt.text = _maxCount.toString();
         countTxtChangeHandler(null);
      }
      
      private function upClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
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
         var _loc4_:int = DeedManager.instance.getOneBuffData(13);
         if(_loc4_ > 0)
         {
            SocketManager.Instance.out.sendHorseUpSkill(_skillExp.skillId,1);
            return;
         }
         if(int(_countTxt.text) <= 0)
         {
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("horse.itemConfirmBuyPrompt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
            _loc3_.moveEnable = false;
            _loc3_.addEventListener("response",buyConfirm,false,0,true);
            return;
         }
         var _loc2_:int = _countTxt.text;
         _loc2_ = Math.min(_loc2_,_maxCount);
         SocketManager.Instance.out.sendHorseUpSkill(_skillExp.skillId,_loc2_);
      }
      
      private function buyConfirm(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",buyConfirm);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            ShopBuyManager.Instance.buy(11165,1,-1);
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
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
      
      private function __toLinkTxtHandler(param1:TextEvent) : void
      {
         SoundManager.instance.playButtonSound();
         StateManager.setState("dungeon");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _bg = null;
         _levelTxt = null;
         _expBg = null;
         _expCover = null;
         _expPerTxt = null;
         _rightArrow = null;
         _countTitleTxt = null;
         _txtBg = null;
         _countTxt = null;
         _maxBtn = null;
         _upBtn = null;
         ObjectUtils.disposeObject(_freeUpBtn);
         _freeUpBtn = null;
         ObjectUtils.disposeObject(_freeUpTxt);
         _freeUpTxt = null;
         _curSkillCell = null;
         _upCurSkillCell = null;
         _upNextSkillCell = null;
         _itemCell = null;
         _skillExp = null;
         _dataList = null;
         ObjectUtils.disposeObject(_toLinkTxt);
         _toLinkTxt = null;
      }
   }
}
