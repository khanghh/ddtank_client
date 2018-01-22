package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortiaDutyInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class JobManageItem extends Sprite implements Disposeable
   {
       
      
      private var _name:FilterFrameText;
      
      private var _btn:TextButton;
      
      private var _light:Bitmap;
      
      private var _nameBG:Scale9CornerImage;
      
      private var _dutyInfo:ConsortiaDutyInfo;
      
      private var _editable:Boolean;
      
      private var _selected:Boolean;
      
      public function JobManageItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _name = ComponentFactory.Instance.creatComponentByStylename("consortion.jobManage.name");
         _btn = ComponentFactory.Instance.creatComponentByStylename("consortion.jobManage.btn");
         _light = ComponentFactory.Instance.creatBitmap("asset.consortion.jobManage.light");
         _nameBG = ComponentFactory.Instance.creatComponentByStylename("consortion.jobManageItem.nameBG");
         addChild(_nameBG);
         addChild(_name);
         addChild(_btn);
         addChild(_light);
         _light.visible = false;
         _nameBG.visible = false;
         _btn.text = LanguageMgr.GetTranslation("change");
         _btn.buttonMode = true;
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",__btnClickHandler);
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__btnClickHandler);
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
      }
      
      public function set dutyInfo(param1:ConsortiaDutyInfo) : void
      {
         _dutyInfo = param1;
         _name.text = _dutyInfo.DutyName;
         selected = false;
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         editable = !editable;
         if(!editable && upText)
         {
            ConsortionModelManager.Instance.model.changeDutyListName(_dutyInfo.DutyID,_name.text);
            SocketManager.Instance.out.sendConsortiaUpdateDuty(_dutyInfo.DutyID,_name.text,_dutyInfo.Level);
         }
      }
      
      public function set editable(param1:Boolean) : void
      {
         _editable = param1;
         var _loc2_:int = !!_editable?2:1;
         _btn.setFrame(_loc2_);
         if(_loc2_ == 1)
         {
            _btn.text = LanguageMgr.GetTranslation("change");
         }
         else
         {
            _btn.text = LanguageMgr.GetTranslation("ok");
         }
         if(_editable)
         {
            _nameBG.visible = true;
            _name.type = "input";
            _name.mouseEnabled = true;
            _name.setFocus();
            _name.setSelection(_name.text.length,_name.text.length);
         }
         else
         {
            _nameBG.visible = false;
            _name.type = "dynamic";
            _name.mouseEnabled = false;
         }
      }
      
      public function get editable() : Boolean
      {
         return _editable;
      }
      
      public function get upText() : Boolean
      {
         var _loc3_:int = 0;
         if(_name.text == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaJobItem.null"));
            setDefultName();
            return false;
         }
         if(_name.text == _dutyInfo.DutyName)
         {
            return false;
         }
         var _loc1_:Vector.<ConsortiaDutyInfo> = ConsortionModelManager.Instance.model.dutyList;
         var _loc2_:int = _loc1_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_loc1_[_loc3_].DutyName == _name.text)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaJobItem.diffrent"));
               setDefultName();
               return false;
            }
            _loc3_++;
         }
         if(FilterWordManager.isGotForbiddenWords(_name.text,"name"))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaJobItem.duty"));
            setDefultName();
            return false;
         }
         return true;
      }
      
      private function setDefultName() : void
      {
         var _loc4_:int = 0;
         var _loc2_:Vector.<ConsortiaDutyInfo> = ConsortionModelManager.Instance.model.dutyList;
         var _loc3_:int = _loc2_.length;
         var _loc1_:int = this.name;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc1_ == _loc4_)
            {
               _name.text = _loc2_[_loc4_].DutyName;
            }
            _loc4_++;
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         _light.visible = _selected;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         _light.visible = true;
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(!selected)
         {
            _light.visible = false;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _name = null;
         _btn = null;
         _light = null;
         _nameBG = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
