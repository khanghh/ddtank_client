package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   import totem.TotemManager;
   import trainer.view.NewHandContainer;
   
   public class TotemMainView extends Sprite implements Disposeable
   {
       
      
      private var _leftView:TotemLeftView;
      
      private var _rightView:TotemRightView;
      
      public function TotemMainView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _leftView = ComponentFactory.Instance.creatCustomObject("totemLeftView");
         _rightView = ComponentFactory.Instance.creatCustomObject("totemRightView");
         addChild(_rightView);
         addChild(_leftView);
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(101))
         {
            if(PlayerManager.Instance.Self.Grade >= 22)
            {
               NewHandContainer.Instance.showArrow(145,0,new Point(313,222),"","",this);
            }
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(136),refresh);
      }
      
      private function refresh(param1:PkgEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc3_:PackageIn = param1.pkg;
         _loc3_.readInt();
         PlayerManager.Instance.Self.damageScores = _loc3_.readInt();
         var _loc2_:int = _loc3_.readInt();
         if(_loc2_ == PlayerManager.Instance.Self.totemId)
         {
            _loc4_ = false;
            SoundManager.instance.play("202");
         }
         else
         {
            SoundManager.instance.play("201");
            _loc4_ = true;
            PlayerManager.Instance.Self.totemId = _loc2_;
            TotemManager.instance.updatePropertyAddtion(PlayerManager.Instance.Self.totemId,PlayerManager.Instance.Self.propertyAddition);
            PlayerManager.Instance.dispatchEvent(new Event("updatePlayerState"));
         }
         _leftView.refreshView(_loc4_);
         _rightView.refreshView();
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(136),refresh);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _leftView = null;
         _rightView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
