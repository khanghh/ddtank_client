package horse.horsePicCherish
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.utils.getTimer;
   import horse.HorseControl;
   import horse.HorseManager;
   import horse.data.HorsePicCherishVo;
   
   public class HorsePicCherishItem extends Component
   {
       
      
      private var _index:int;
      
      private var _bg:Bitmap;
      
      private var _horseIcon:Bitmap;
      
      private var _data:HorsePicCherishVo;
      
      private var _horseName:FilterFrameText;
      
      private var _myColorMatrix_filter:ColorMatrixFilter;
      
      private var _state:Array;
      
      private var _useBtn:TextButton;
      
      private var _activeBtn:TextButton;
      
      private var _stateArr:Array;
      
      private var _propertyTxtArr:Array;
      
      private var _propertyValueArr:Array;
      
      private var _lastClickTime:int = 0;
      
      public function HorsePicCherishItem(index:int, data:HorsePicCherishVo)
      {
         super();
         _index = index;
         _data = data;
         if(_data)
         {
            _stateArr = LanguageMgr.GetTranslation("ddt.totem.totemPointTip.statusValueTxt").split(",");
            _propertyTxtArr = LanguageMgr.GetTranslation("horse.horsePicCherish.peopertyTxt").split(",");
            _propertyValueArr = HorseControl.instance.getHorsePicCherishAddProperty(data.ID);
         }
         initView();
         initEvent();
         updateView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("horse.pic.frame");
         addChild(_bg);
         width = _bg.width;
         height = _bg.height;
         _horseIcon = ComponentFactory.Instance.creat("horse.pic.icon" + _index);
         addChild(_horseIcon);
         if(_index != -1)
         {
            _horseName = ComponentFactory.Instance.creatComponentByStylename("horse.HorsePicCherish.nameTxt");
            _horseName.text = _data.Name;
            addChild(_horseName);
            _useBtn = ComponentFactory.Instance.creatComponentByStylename("horsePicCherish.useBtn");
            addChild(_useBtn);
            _useBtn.text = LanguageMgr.GetTranslation("horse.horsePicCherish.use");
            _activeBtn = ComponentFactory.Instance.creatComponentByStylename("horsePicCherish.activeBtn");
            addChild(_activeBtn);
            _activeBtn.text = LanguageMgr.GetTranslation("horse.horsePicCherish.active");
         }
         _myColorMatrix_filter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
      }
      
      private function initEvent() : void
      {
         if(_useBtn)
         {
            _useBtn.addEventListener("click",__useHandler);
         }
         if(_activeBtn)
         {
            _activeBtn.addEventListener("click",__activeHandler);
         }
         HorseManager.instance.addEventListener("changeHorseByPicCherish",__changeHorseHandler);
      }
      
      protected function __changeHorseHandler(event:Event) : void
      {
         updateView();
      }
      
      protected function __activeHandler(event:MouseEvent) : void
      {
         var place:int = 0;
         SoundManager.instance.playButtonSound();
         if(getTimer() - _lastClickTime < 2000)
         {
            return;
         }
         _lastClickTime = getTimer();
         if(!_data)
         {
            return;
         }
         _state = HorseControl.instance.getHorsePicCherishState(_data.ID,_data.TemplateId);
         if(_state[0])
         {
            return;
         }
         if(_state[1])
         {
            place = PlayerManager.Instance.Self.getBag(1).getItemByTemplateId(_data.TemplateId).Place;
            SocketManager.Instance.out.sendActiveHorsePicCherish(place);
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("horse.horsePicCherish.noPic"));
      }
      
      protected function __useHandler(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_data || !_state[0])
         {
            return;
         }
         SocketManager.Instance.out.sendHorseChangeHorse(_data.ID);
      }
      
      private function updateView() : void
      {
         var tip:* = null;
         var i:int = 0;
         var beginDate:* = null;
         var valid:int = 0;
         if(_data)
         {
            _state = HorseControl.instance.getHorsePicCherishState(_data.ID,_data.TemplateId);
            if(!tipData)
            {
               tip = {};
               tip.title = LanguageMgr.GetTranslation("horse.horsePicCherish.frameTitleTxt");
               tip.type = LanguageMgr.GetTranslation("horse.horsePicCherish.frameTitleTxt");
               tipData = tip;
            }
            tipData.state = !!_state[0]?_stateArr[0]:_stateArr[1];
            tipData.isActivate = _state[0];
            tipData.activeValue = ItemManager.Instance.getTemplateById(_data.TemplateId).Name;
            tipData.propertyValue = "";
            tipData.isActive = _state[0];
            for(i = 0; i < _propertyValueArr.length; )
            {
               if(_propertyValueArr[i] != 0)
               {
                  tipData.propertyValue = tipData.propertyValue + (_propertyTxtArr[i] + _propertyValueArr[i] + "\n");
               }
               i++;
            }
            tipData.getValue = LanguageMgr.GetTranslation("horse.pic.getTxt");
            if(PlayerManager.Instance.Self.horsePicCherishDic.hasKey(_data.ID))
            {
               beginDate = PlayerManager.Instance.Self.horsePicCherishDic[_data.ID].beginDate;
               valid = PlayerManager.Instance.Self.horsePicCherishDic[_data.ID].valid;
               if(valid == 0)
               {
                  tipData.valid = 2147483647;
               }
               else
               {
                  tipData.valid = valid * 86400000 + beginDate.getTime();
               }
            }
         }
         if(!_data)
         {
            var _loc5_:* = [_myColorMatrix_filter];
            _horseIcon.filters = _loc5_;
            _bg.filters = _loc5_;
         }
         else if(_state[0])
         {
            if(!_state[2])
            {
               _useBtn.visible = true;
               _activeBtn.visible = false;
            }
            else
            {
               _loc5_ = false;
               _activeBtn.visible = _loc5_;
               _useBtn.visible = _loc5_;
            }
            _loc5_ = null;
            _horseIcon.filters = _loc5_;
            _loc5_ = _loc5_;
            _bg.filters = _loc5_;
            _horseName.filters = _loc5_;
         }
         else if(_state[1])
         {
            _useBtn.visible = false;
            _activeBtn.visible = true;
            _loc5_ = [_myColorMatrix_filter];
            _horseIcon.filters = _loc5_;
            _loc5_ = _loc5_;
            _bg.filters = _loc5_;
            _horseName.filters = _loc5_;
         }
         else
         {
            _useBtn.visible = false;
            _activeBtn.visible = true;
            _loc5_ = [_myColorMatrix_filter];
            _horseIcon.filters = _loc5_;
            _loc5_ = _loc5_;
            _bg.filters = _loc5_;
            _horseName.filters = _loc5_;
         }
      }
      
      private function removeEvent() : void
      {
         if(_useBtn)
         {
            _useBtn.removeEventListener("click",__useHandler);
         }
         if(_activeBtn)
         {
            _activeBtn.removeEventListener("click",__activeHandler);
         }
         HorseManager.instance.removeEventListener("changeHorseByPicCherish",__changeHorseHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_horseIcon);
         _horseIcon = null;
         ObjectUtils.disposeObject(_horseName);
         _horseName = null;
         ObjectUtils.disposeObject(_activeBtn);
         _activeBtn = null;
         ObjectUtils.disposeObject(_useBtn);
         _useBtn = null;
         _propertyValueArr = null;
         _propertyTxtArr = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
