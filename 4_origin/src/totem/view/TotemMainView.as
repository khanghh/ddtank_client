package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   import totem.TotemManager;
   import trainer.view.NewHandContainer;
   
   public class TotemMainView extends Sprite implements Disposeable
   {
       
      
      private var _leftView:TotemLeftActiveView;
      
      private var _rightView:TotemRightView;
      
      public function TotemMainView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _leftView = new TotemLeftActiveView();
         PositionUtils.setPos(_leftView,"totem.leftActiveViewPos");
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
      
      private function refresh(event:PkgEvent) : void
      {
         var isSuccess:Boolean = false;
         var pkg:PackageIn = event.pkg;
         pkg.readInt();
         PlayerManager.Instance.Self.damageScores = pkg.readInt();
         var id:int = pkg.readInt();
         if(id == PlayerManager.Instance.Self.totemId)
         {
            isSuccess = false;
            SoundManager.instance.play("202");
         }
         else
         {
            SoundManager.instance.play("201");
            isSuccess = true;
            PlayerManager.Instance.Self.totemId = id;
            TotemManager.instance.updatePropertyAddtion(PlayerManager.Instance.Self.totemId,PlayerManager.Instance.Self.propertyAddition,null);
            PlayerManager.Instance.dispatchEvent(new Event("updatePlayerState"));
         }
         _leftView.refreshView(isSuccess);
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
         _leftView.dispose();
         _rightView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
