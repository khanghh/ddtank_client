package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ChairmanChannelPanel extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _declaration:TextButton;
      
      private var _jobManage:TextButton;
      
      private var _transfer:TextButton;
      
      private var _upGrade:TextButton;
      
      private var _mail:TextButton;
      
      private var _task:TextButton;
      
      public function ChairmanChannelPanel()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.chairmanChannel.bg");
         _declaration = ComponentFactory.Instance.creatComponentByStylename("consortion.chairmanChannel.declaration");
         _declaration.text = LanguageMgr.GetTranslation("consortia.chairmanChannel.BtnText1");
         _jobManage = ComponentFactory.Instance.creatComponentByStylename("consortion.chairmanChannel.jobManage");
         _jobManage.text = LanguageMgr.GetTranslation("consortia.chairmanChannel.BtnText2");
         _transfer = ComponentFactory.Instance.creatComponentByStylename("consortion.chairmanChannel.transfer");
         _transfer.text = LanguageMgr.GetTranslation("consortia.chairmanChannel.BtnText3");
         _upGrade = ComponentFactory.Instance.creatComponentByStylename("consortion.chairmanChannel.upGrade");
         _upGrade.text = LanguageMgr.GetTranslation("consortia.chairmanChannel.BtnText4");
         _mail = ComponentFactory.Instance.creatComponentByStylename("consortion.chairmanChannel.mail");
         _mail.text = LanguageMgr.GetTranslation("consortia.chairmanChannel.BtnText5");
         _task = ComponentFactory.Instance.creatComponentByStylename("consortion.chairmanChannel.task");
         _task.text = LanguageMgr.GetTranslation("consortia.chairmanChannel.BtnText6");
         addChild(_bg);
         addChild(_declaration);
         addChild(_jobManage);
         addChild(_transfer);
         addChild(_mail);
         addChild(_task);
      }
      
      private function initEvent() : void
      {
         _upGrade.addEventListener("click",__clickHandler);
         _transfer.addEventListener("click",__clickHandler);
         _jobManage.addEventListener("click",__clickHandler);
         _declaration.addEventListener("click",__clickHandler);
         _mail.addEventListener("click",__clickHandler);
         _task.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_upGrade)
         {
            _upGrade.removeEventListener("click",__clickHandler);
         }
         if(_transfer)
         {
            _transfer.removeEventListener("click",__clickHandler);
         }
         if(_jobManage)
         {
            _jobManage.removeEventListener("click",__clickHandler);
         }
         if(_declaration)
         {
            _declaration.removeEventListener("click",__clickHandler);
         }
         if(_mail)
         {
            _mail.removeEventListener("click",__clickHandler);
         }
         if(_task)
         {
            _task.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc7_:* = param1.currentTarget;
         if(_upGrade !== _loc7_)
         {
            if(_transfer !== _loc7_)
            {
               if(_jobManage !== _loc7_)
               {
                  if(_declaration !== _loc7_)
                  {
                     if(_mail !== _loc7_)
                     {
                        if(_task === _loc7_)
                        {
                           ConsortionModelManager.Instance.TaskModel.showReleaseFrame();
                        }
                     }
                     else
                     {
                        _loc2_ = ComponentFactory.Instance.creatComponentByStylename("consortionMailFrame");
                        LayerManager.Instance.addToLayer(_loc2_,3,true,1);
                     }
                  }
                  else
                  {
                     _loc5_ = ComponentFactory.Instance.creatComponentByStylename("consortionDeclareFrame");
                     LayerManager.Instance.addToLayer(_loc5_,3,true,1);
                  }
               }
               else
               {
                  _loc3_ = ComponentFactory.Instance.creatComponentByStylename("consortionJobManageFrame");
                  LayerManager.Instance.addToLayer(_loc3_,3,true,1);
                  ConsortionModelManager.Instance.loadDutyList(ConsortionModelManager.Instance.dutyListComplete,PlayerManager.Instance.Self.ConsortiaID);
               }
            }
            else
            {
               _loc4_ = ComponentFactory.Instance.creatComponentByStylename("consortionTrasferFrame");
               LayerManager.Instance.addToLayer(_loc4_,3,true,1);
            }
         }
         else
         {
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("consortionUpGradeFrame");
            LayerManager.Instance.addToLayer(_loc6_,3,true,1);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         if(_declaration)
         {
            ObjectUtils.disposeObject(_declaration);
         }
         _declaration = null;
         if(_jobManage)
         {
            ObjectUtils.disposeObject(_jobManage);
         }
         _jobManage = null;
         if(_transfer)
         {
            ObjectUtils.disposeObject(_transfer);
         }
         _transfer = null;
         if(_upGrade)
         {
            ObjectUtils.disposeObject(_upGrade);
         }
         _upGrade = null;
         if(_mail)
         {
            ObjectUtils.disposeObject(_mail);
         }
         _mail = null;
         if(_task)
         {
            ObjectUtils.disposeObject(_task);
         }
         _task = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
