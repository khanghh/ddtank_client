package totem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import totem.HonorUpManager;
   
   public class HonorUpIcon extends Sprite implements Disposeable
   {
       
      
      private var _iconBtn:SimpleBitmapButton;
      
      private var _countTxt:FilterFrameText;
      
      public function HonorUpIcon()
      {
         super();
         this.mouseEnabled = false;
         _iconBtn = ComponentFactory.Instance.creatComponentByStylename("totem.honorUpIcon.btn");
         _iconBtn.addEventListener("click",openHonorUpFrame,false,0,true);
         _iconBtn.enable = false;
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("totem.honorUpIcon.countTxt");
         addChild(_iconBtn);
         addChild(_countTxt);
         HonorUpManager.instance.addEventListener("up_count_update",refreshShow,false,0,true);
         if(HonorUpManager.instance.upCount >= 0)
         {
            refreshShow(null);
         }
         else
         {
            SocketManager.Instance.out.sendHonorUp(1,false);
         }
      }
      
      private function refreshShow(param1:Event) : void
      {
         _iconBtn.enable = true;
         _countTxt.text = (HonorUpManager.instance.dataList.length - HonorUpManager.instance.upCount).toString();
      }
      
      private function openHonorUpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(HonorUpManager.instance.upCount >= HonorUpManager.instance.dataList.length)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.totem.honorUp.cannot"));
            return;
         }
         var _loc2_:HonorUpFrame = ComponentFactory.Instance.creatComponentByStylename("totem.honorUpFrame");
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      public function dispose() : void
      {
         _iconBtn.removeEventListener("click",openHonorUpFrame);
         HonorUpManager.instance.removeEventListener("up_count_update",refreshShow);
         ObjectUtils.disposeAllChildren(this);
         _iconBtn = null;
         _countTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
