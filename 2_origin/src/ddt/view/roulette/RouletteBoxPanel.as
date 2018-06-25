package ddt.view.roulette
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SoundManager;
   
   public class RouletteBoxPanel extends Frame
   {
       
      
      private var _view:RouletteView;
      
      private var _templateIDList:Array;
      
      private var _keyCount:int;
      
      private var _oldBjYYVolNum:int;
      
      private var _oldYxYYVolNum:int;
      
      public function RouletteBoxPanel()
      {
         super();
         initII();
      }
      
      private function initII() : void
      {
         var i:int = 0;
         var info:* = null;
         _templateIDList = [];
         for(i = 0; i < 18; )
         {
            info = new BoxGoodsTempInfo();
            info.TemplateId = 11013;
            info.IsBind = true;
            info.ItemCount = 2;
            info.ItemValid = 7;
            _templateIDList.push(info);
            i++;
         }
         _keyCount = 10;
         escEnable = true;
         addEventListener("response",_response);
         _oldBjYYVolNum = SharedManager.Instance.musicVolumn;
         _oldYxYYVolNum = SharedManager.Instance.soundVolumn;
         if(SharedManager.Instance.musicVolumn >= 25)
         {
            SharedManager.Instance.musicVolumn = 25;
         }
         SharedManager.Instance.soundVolumn = 80;
         SharedManager.Instance.changed();
      }
      
      private function _response(evt:FrameEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.play("008");
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            if(!_view.isCanClose && _view.selectNumber < 8)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.rouletteview.quit"));
            }
            else
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.rouletteview.close"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               alert.addEventListener("response",_responseII);
            }
         }
      }
      
      private function _responseII(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         evt.currentTarget.removeEventListener("response",_responseII);
         ObjectUtils.disposeObject(evt.target);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            dispose();
         }
      }
      
      public function set templateIDList(arr:Array) : void
      {
         _templateIDList = arr;
      }
      
      public function set keyCount(value:int) : void
      {
         _keyCount = value;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.view.rouletteView.title");
         _view = ComponentFactory.Instance.creat("ddt.view.roulette.RouletteView",[_templateIDList]);
         _view.keyCount = _keyCount;
         addToContent(_view);
      }
      
      override public function dispose() : void
      {
         SharedManager.Instance.musicVolumn = _oldBjYYVolNum;
         SharedManager.Instance.soundVolumn = _oldYxYYVolNum;
         SharedManager.Instance.changed();
         removeEventListener("response",_response);
         super.dispose();
         _view = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
