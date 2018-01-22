package bagAndInfo.info
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.EffortManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import hall.event.NewHallEvent;
   import newTitle.NewTitleManager;
   import newTitle.event.NewTitleEvent;
   
   public class PlayerInfoEffortHonorView extends Sprite implements Disposeable
   {
       
      
      private var _nameChoose:ComboBox;
      
      private var _honorArray:Array;
      
      public function PlayerInfoEffortHonorView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _nameChoose = ComponentFactory.Instance.creatComponentByStylename("personInfoViewNameChoose");
         addChild(_nameChoose);
         _nameChoose.button.addEventListener("click",__buttonClick);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
         NewTitleManager.instance.addEventListener("selectTitle",__onSelectTitle);
         setlist(EffortManager.Instance.getHonorArray());
         update();
      }
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["honor"] == true)
         {
            if(PlayerManager.Instance.Self.honor != "")
            {
               _nameChoose.textField.text = PlayerManager.Instance.Self.honor;
               SocketManager.Instance.dispatchEvent(new NewHallEvent("newhallupdatetitle"));
               NewTitleManager.instance.dispatchEvent(new NewTitleEvent("setSelectTitle"));
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newTitleView.useTitleSuccessTxt",_nameChoose.textField.text));
            }
            else
            {
               _nameChoose.textField.text = LanguageMgr.GetTranslation("bagAndInfo.info.PlayerInfoEffortHonorView.selecting");
            }
         }
      }
      
      private function __buttonClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         NewTitleManager.instance.show();
      }
      
      private function update() : void
      {
         if(PlayerManager.Instance.Self.honor != "")
         {
            _nameChoose.textField.text = PlayerManager.Instance.Self.honor;
         }
         else
         {
            _nameChoose.textField.text = LanguageMgr.GetTranslation("bagAndInfo.info.PlayerInfoEffortHonorView.selecting");
         }
      }
      
      private function __onSelectTitle(param1:NewTitleEvent) : void
      {
         var _loc2_:String = param1.data[0];
         if(_loc2_)
         {
            SocketManager.Instance.out.sendReworkRank(_loc2_);
         }
         else
         {
            SocketManager.Instance.out.sendReworkRank("");
            _nameChoose.textField.text = LanguageMgr.GetTranslation("bagAndInfo.info.PlayerInfoEffortHonorView.selecting");
         }
      }
      
      public function setlist(param1:Array) : void
      {
         _honorArray = [];
         _honorArray = param1;
         if(!_honorArray)
         {
            return;
         }
      }
      
      public function dispose() : void
      {
         NewTitleManager.instance.removeEventListener("selectTitle",__onSelectTitle);
         _nameChoose.button.removeEventListener("click",__buttonClick);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
         if(_nameChoose)
         {
            ObjectUtils.disposeObject(_nameChoose);
         }
         _nameChoose = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
