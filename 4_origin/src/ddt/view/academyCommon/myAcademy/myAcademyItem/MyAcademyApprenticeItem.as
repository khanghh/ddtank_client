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
       
      
      public function MyAcademyApprenticeItem()
      {
         super();
      }
      
      override protected function initComponent() : void
      {
         _removeGold = 20000;
         _sexIcon.visible = false;
      }
      
      override protected function __removeClick(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc4_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("AlertDialog.Info"));
         if(!getTimerOvertop())
         {
            _loc4_.data = LanguageMgr.GetTranslation("ddt.view.academyCommon.myAcademy.MyAcademyMasterItem.remove",_info.NickName);
            _loc3_ = AlertManager.Instance.alert("academySimpleAlert",_loc4_,2);
            _loc3_.addEventListener("response",__frameEvent);
         }
         else
         {
            _loc4_.data = LanguageMgr.GetTranslation("ddt.view.academyCommon.myAcademy.MyAcademyApprenticeItem.removeIII",_info.NickName);
            _loc2_ = AlertManager.Instance.alert("academySimpleAlert",_loc4_,2);
            _loc2_.addEventListener("response",__alerFrameEvent);
         }
      }
      
      override protected function __frameEvent(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__frameEvent);
         (param1.currentTarget as BaseAlerFrame).dispose();
         SoundManager.instance.play("008");
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.Gold >= 20000)
               {
                  submit();
                  break;
               }
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
               _loc2_.moveEnable = false;
               _loc2_.addEventListener("response",__quickBuyResponse);
               break;
         }
      }
      
      override protected function submit() : void
      {
         SocketManager.Instance.out.sendAcademyFireApprentice(_info.ID);
      }
   }
}
