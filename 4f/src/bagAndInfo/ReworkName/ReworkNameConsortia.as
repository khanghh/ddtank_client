package bagAndInfo.ReworkName
{
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.ReworkNameAnalyzer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.FilterWordManager;
   import flash.events.Event;
   import road7th.utils.StringHelper;
   
   public class ReworkNameConsortia extends ReworkNameFrame
   {
       
      
      public function ReworkNameConsortia(){super();}
      
      override protected function configUi() : void{}
      
      override protected function __onInputChange(param1:Event) : void{}
      
      override protected function nameInputCheck() : Boolean{return false;}
      
      override protected function setCheckTxt(param1:String) : void{}
      
      override protected function submitCheckCallBack(param1:ReworkNameAnalyzer) : void{}
   }
}
