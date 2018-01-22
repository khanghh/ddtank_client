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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _templateIDList = [];
         _loc2_ = 0;
         while(_loc2_ < 18)
         {
            _loc1_ = new BoxGoodsTempInfo();
            _loc1_.TemplateId = 11013;
            _loc1_.IsBind = true;
            _loc1_.ItemCount = 2;
            _loc1_.ItemValid = 7;
            _templateIDList.push(_loc1_);
            _loc2_++;
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
      
      private function _response(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            if(!_view.isCanClose && _view.selectNumber < 8)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.rouletteview.quit"));
            }
            else
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.rouletteview.close"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               _loc2_.addEventListener("response",_responseII);
            }
         }
      }
      
      private function _responseII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         param1.currentTarget.removeEventListener("response",_responseII);
         ObjectUtils.disposeObject(param1.target);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            dispose();
         }
      }
      
      public function set templateIDList(param1:Array) : void
      {
         _templateIDList = param1;
      }
      
      public function set keyCount(param1:int) : void
      {
         _keyCount = param1;
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
