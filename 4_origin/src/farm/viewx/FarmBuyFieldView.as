package farm.viewx
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class FarmBuyFieldView extends Sprite implements Disposeable
   {
       
      
      private var _bg1:MutipleImage;
      
      private var _bg2:ScaleBitmapImage;
      
      private var _titleBg:Bitmap;
      
      private var _title:FilterFrameText;
      
      private var _close:SimpleBitmapButton;
      
      private var _cancel:TextButton;
      
      private var _ok:TextButton;
      
      private var _timeTitle:FilterFrameText;
      
      private var _bg3:Scale9CornerImage;
      
      private var _week:SelectedCheckButton;
      
      private var _month:SelectedCheckButton;
      
      private var _all:SelectedCheckButton;
      
      private var _bg4:Bitmap;
      
      private var _needTxt:FilterFrameText;
      
      private var _money:FilterFrameText;
      
      private var _group:SelectedButtonGroup;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _fieldId:int;
      
      private var _moneyNum:int;
      
      private var _moneyConfirm:BaseAlerFrame;
      
      private var _isBand:Boolean;
      
      private var _back;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      public function FarmBuyFieldView(fieldid:int)
      {
         super();
         _fieldId = fieldid;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("farm.buyFieldView.bg");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("farm.buyFieldView.bg2");
         _titleBg = ComponentFactory.Instance.creatBitmap("assets.farm.titleSmall");
         PositionUtils.setPos(_titleBg,"farm.buyView.titlePos");
         _title = ComponentFactory.Instance.creatComponentByStylename("farm.buyFieldView.titleText");
         _title.text = LanguageMgr.GetTranslation("ddt.farm.spreadTitle");
         _close = ComponentFactory.Instance.creatComponentByStylename("farm.closeBtn");
         PositionUtils.setPos(_close,"farm.buyView.closePos");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("farm.buyFieldView.cancel");
         _cancel.text = LanguageMgr.GetTranslation("cancel");
         _ok = ComponentFactory.Instance.creatComponentByStylename("farm.buyFieldView.ok");
         _ok.text = LanguageMgr.GetTranslation("ok");
         _timeTitle = ComponentFactory.Instance.creatComponentByStylename("farm.buyview.timeTitle");
         _timeTitle.text = LanguageMgr.GetTranslation("ddt.farm.spreadTime");
         _bg3 = ComponentFactory.Instance.creatComponentByStylename("farm.buyview.bg3");
         _week = ComponentFactory.Instance.creatComponentByStylename("farm.buyview.week");
         _week.text = LanguageMgr.GetTranslation("ddt.farm.spreadTime1");
         _month = ComponentFactory.Instance.creatComponentByStylename("farm.buyview.month");
         _month.text = LanguageMgr.GetTranslation("ddt.farm.spreadTime2");
         _all = ComponentFactory.Instance.creatComponentByStylename("farm.buyview.all");
         _all.text = LanguageMgr.GetTranslation("ddt.farm.spreadTime3");
         _bg4 = ComponentFactory.Instance.creatBitmap("asset.spread.showFeeBg");
         PositionUtils.setPos(_bg4,"farm.buyView.bg4Pos");
         _needTxt = ComponentFactory.Instance.creatComponentByStylename("farm.buyview.needText");
         _needTxt.text = LanguageMgr.GetTranslation("ddt.farm.spread.payMoney");
         _money = ComponentFactory.Instance.creatComponentByStylename("farm.buyview.money");
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_week);
         _group.addSelectItem(_month);
         _group.selectIndex = 1;
         _all.selected = false;
         addChild(_bg1);
         addChild(_bg2);
         addChild(_titleBg);
         addChild(_title);
         addChild(_close);
         addChild(_cancel);
         addChild(_ok);
         addChild(_bg3);
         addChild(_week);
         addChild(_month);
         addChild(_all);
         addChild(_bg4);
         addChild(_needTxt);
         addChild(_money);
         addChild(_timeTitle);
         _back = ComponentFactory.Instance.creat("asset.core.stranDown");
         _back.x = 170;
         _back.y = 291;
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("Farm.bandMoney.Text1");
         _moneyTxt.text = LanguageMgr.GetTranslation("money");
         _moneyTxt.x = 114;
         _moneyTxt.y = 145;
         addChild(_moneyTxt);
         _bandMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("Farm.bandMoney.Text2");
         _bandMoneyTxt.text = LanguageMgr.GetTranslation("ddtMoney");
         _bandMoneyTxt.x = 225;
         _bandMoneyTxt.y = 145;
         addChild(_bandMoneyTxt);
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("com.frme.fresh.selectBtn");
         _selectedBtn.x = 81;
         _selectedBtn.y = 139;
         _selectedBtn.enable = false;
         _selectedBtn.selected = true;
         addChild(_selectedBtn);
         _selectedBtn.text = LanguageMgr.GetTranslation("money");
         _selectedBtn.addEventListener("click",seletedHander);
         _isBand = false;
         _selectedBandBtn = ComponentFactory.Instance.creatComponentByStylename("com.frme.fresh.selectbandBtn");
         _selectedBandBtn.enable = true;
         _selectedBandBtn.x = 205;
         _selectedBandBtn.y = 139;
         _selectedBandBtn.text = LanguageMgr.GetTranslation("ddtMoney");
         addChild(_selectedBandBtn);
         _selectedBandBtn.addEventListener("click",selectedBandHander);
         upMoney();
      }
      
      protected function selectedBandHander(event:MouseEvent) : void
      {
         if(_selectedBandBtn.selected)
         {
            _isBand = true;
            _selectedBandBtn.enable = false;
            _selectedBtn.selected = false;
            _selectedBtn.enable = true;
         }
         else
         {
            _isBand = false;
         }
         upMoney();
      }
      
      protected function seletedHander(event:MouseEvent) : void
      {
         if(_selectedBtn.selected)
         {
            _isBand = false;
            _selectedBandBtn.selected = false;
            _selectedBandBtn.enable = true;
            _selectedBtn.enable = false;
         }
         else
         {
            _isBand = true;
         }
         upMoney();
      }
      
      private function addEvent() : void
      {
         _close.addEventListener("click",__close);
         _cancel.addEventListener("click",__close);
         _ok.addEventListener("click",__ok);
         _group.addEventListener("change",__changeHandler);
         _all.addEventListener("select",__all);
         StageReferance.stage.addEventListener("keyDown",__onKeyDown);
      }
      
      private function removeEvent() : void
      {
         _close.removeEventListener("click",__close);
         _cancel.removeEventListener("click",__close);
         _ok.removeEventListener("click",__ok);
         _all.removeEventListener("select",__all);
         _group.removeEventListener("change",__changeHandler);
         StageReferance.stage.removeEventListener("keyDown",__onKeyDown);
      }
      
      protected function __onKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == 27)
         {
            SoundManager.instance.play("008");
            dispose();
            event.stopImmediatePropagation();
         }
      }
      
      private function upMoney() : void
      {
         var str:* = null;
         if(_all.selected)
         {
            _moneyNum = _group.selectIndex == 0?getallField().length * FarmModelController.instance.model.payFieldMoneyToWeek:Number(getallField().length * FarmModelController.instance.model.payFieldMoneyToMonth);
         }
         else
         {
            _moneyNum = _group.selectIndex == 0?FarmModelController.instance.model.payFieldMoneyToWeek:int(FarmModelController.instance.model.payFieldMoneyToMonth);
         }
         if(_selectedBandBtn.selected)
         {
            str = "ddtMoney";
         }
         else
         {
            str = "money";
         }
         _money.text = _moneyNum + LanguageMgr.GetTranslation(str);
      }
      
      protected function __all(event:Event) : void
      {
         SoundManager.instance.play("008");
         upMoney();
      }
      
      private function __changeHandler(event:Event) : void
      {
         SoundManager.instance.play("008");
         upMoney();
      }
      
      protected function __ok(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CheckMoneyUtils.instance.checkMoney(_isBand,_moneyNum,onCheckComplete);
      }
      
      protected function onCheckComplete() : void
      {
         var arr:Array = [];
         if(_all.selected)
         {
            arr = getallField();
         }
         else
         {
            arr.push(_fieldId);
         }
         var paytime:int = _group.selectIndex == 0?FarmModelController.instance.model.payFieldTimeToWeek:int(FarmModelController.instance.model.payFieldTimeToMonth);
         FarmModelController.instance.payField(arr,paytime,_isBand);
         dispose();
      }
      
      private function __moneyConfirmHandler(evt:FrameEvent) : void
      {
         _moneyConfirm.removeEventListener("response",__moneyConfirmHandler);
         _moneyConfirm.dispose();
         _moneyConfirm = null;
         switch(int(evt.responseCode) - 2)
         {
            case 0:
            case 1:
               LeavePageManager.leaveToFillPath();
         }
      }
      
      private function getallField() : Array
      {
         var arr:* = null;
         var i:int = 0;
         arr = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
         arr = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
         for(i = 0; i < FarmModelController.instance.model.fieldsInfo.length; )
         {
            if(FarmModelController.instance.model.fieldsInfo[i].isDig)
            {
               arr.splice(arr.indexOf(i),1);
            }
            i++;
         }
         return arr;
      }
      
      protected function __close(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg1)
         {
            ObjectUtils.disposeObject(_bg1);
         }
         _bg1 = null;
         if(_bg2)
         {
            ObjectUtils.disposeObject(_bg2);
         }
         _bg2 = null;
         if(_titleBg)
         {
            ObjectUtils.disposeObject(_titleBg);
         }
         _titleBg = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_close)
         {
            ObjectUtils.disposeObject(_close);
         }
         _close = null;
         if(_cancel)
         {
            ObjectUtils.disposeObject(_cancel);
         }
         _cancel = null;
         if(_ok)
         {
            ObjectUtils.disposeObject(_ok);
         }
         _ok = null;
         if(_timeTitle)
         {
            ObjectUtils.disposeObject(_timeTitle);
         }
         _timeTitle = null;
         if(_bg3)
         {
            ObjectUtils.disposeObject(_bg3);
         }
         _bg3 = null;
         if(_week)
         {
            ObjectUtils.disposeObject(_week);
         }
         _week = null;
         if(_month)
         {
            ObjectUtils.disposeObject(_month);
         }
         _month = null;
         if(_all)
         {
            ObjectUtils.disposeObject(_all);
         }
         _all = null;
         if(_bg4)
         {
            ObjectUtils.disposeObject(_bg4);
         }
         _bg4 = null;
         if(_needTxt)
         {
            ObjectUtils.disposeObject(_needTxt);
         }
         _needTxt = null;
         if(_money)
         {
            ObjectUtils.disposeObject(_money);
         }
         _money = null;
         if(_selectedBtn)
         {
            ObjectUtils.disposeObject(_selectedBtn);
         }
         _selectedBtn = null;
         if(_selectedBandBtn)
         {
            ObjectUtils.disposeObject(_selectedBandBtn);
         }
         _selectedBandBtn = null;
         if(_moneyTxt)
         {
            ObjectUtils.disposeObject(_moneyTxt);
         }
         _moneyTxt = null;
         if(_bandMoneyTxt)
         {
            ObjectUtils.disposeObject(_bandMoneyTxt);
         }
         _bandMoneyTxt = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
