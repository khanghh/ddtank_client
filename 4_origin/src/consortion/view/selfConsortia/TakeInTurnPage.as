package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TakeInTurnPage extends Sprite implements Disposeable
   {
      
      public static const PAGE_CHANGE:String = "pageChange";
       
      
      private var _bg:Scale9CornerImage;
      
      private var _next:BaseButton;
      
      private var _pre:BaseButton;
      
      private var _page:FilterFrameText;
      
      private var _present:int = 1;
      
      private var _sum:int = 1;
      
      public function TakeInTurnPage()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get present() : int
      {
         return _present;
      }
      
      public function set present(param1:int) : void
      {
         _present = param1;
         setPage();
      }
      
      public function get sum() : int
      {
         return _sum;
      }
      
      public function set sum(param1:int) : void
      {
         _sum = param1 < 1?1:param1;
         if(_present > _sum)
         {
            _present = 1;
         }
         setPage();
         setBtnState();
      }
      
      private function setPage() : void
      {
         _page.text = _present + "/" + _sum;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("consortion.takeIn.pageBg");
         _next = ComponentFactory.Instance.creatComponentByStylename("consortion.takeInItem.turnPage.next");
         _pre = ComponentFactory.Instance.creatComponentByStylename("consortion.takeInItem.turnPage.pre");
         _page = ComponentFactory.Instance.creatComponentByStylename("consortion.takeInItem.turnPage.page");
         addChild(_bg);
         addChild(_next);
         addChild(_pre);
         addChild(_page);
      }
      
      private function initEvent() : void
      {
         _next.addEventListener("click",__nextHanlder);
         _pre.addEventListener("click",__preHanlder);
      }
      
      private function removeEvent() : void
      {
         _next.removeEventListener("click",__nextHanlder);
         _pre.removeEventListener("click",__preHanlder);
      }
      
      private function __nextHanlder(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         present = Number(present) + 1;
         if(_present > _sum)
         {
            present = sum;
         }
         else
         {
            dispatchEvent(new Event("pageChange"));
         }
         setBtnState();
      }
      
      private function setBtnState() : void
      {
         if(present == 1)
         {
            _pre.enable = false;
            _pre.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            _pre.enable = true;
            _pre.filters = null;
         }
         if(present == sum)
         {
            _next.enable = false;
            _next.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            _next.enable = true;
            _next.filters = null;
         }
      }
      
      private function __preHanlder(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         present = Number(present) - 1;
         if(_present < 1)
         {
            present = 1;
         }
         else
         {
            dispatchEvent(new Event("pageChange"));
         }
         setBtnState();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg.dispose();
         _bg = null;
         _next = null;
         _pre = null;
         _page = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
