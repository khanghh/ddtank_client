package ddt.view.academyCommon.myAcademy.myAcademyItem
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class MyAcademyApprenticeItem extends MyAcademyMasterItem implements Disposeable
   {
       
      
      public function MyAcademyApprenticeItem(){super();}
      
      override protected function initComponent() : void{}
      
      override protected function __removeClick(param1:MouseEvent) : void{}
      
      override protected function __frameEvent(param1:FrameEvent) : void{}
      
      override protected function submit() : void{}
   }
}
