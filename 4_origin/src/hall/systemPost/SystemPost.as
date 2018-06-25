package hall.systemPost
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.SystemPostManager;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import hall.event.NewHallEvent;
   
   public class SystemPost extends Sprite implements Disposeable
   {
       
      
      private var _indentationBtn:SelectedButton;
      
      private var _postSprite:Sprite;
      
      private var _postBg:Bitmap;
      
      private var _currItem:SystemPostItem;
      
      public function SystemPost()
      {
         super();
         initView();
         initEvent();
         initData();
         initMask();
      }
      
      private function initMask() : void
      {
         var shape:Shape = new Shape();
         shape.graphics.beginFill(0,0.5);
         shape.graphics.drawRect(0,0,_postBg.width,_postBg.height);
         shape.graphics.endFill();
         shape.x = 0;
         shape.y = this.y;
         addChild(shape);
         _postSprite.mask = shape;
      }
      
      private function initView() : void
      {
         _indentationBtn = ComponentFactory.Instance.creatComponentByStylename("hall.systemPost.indentationBtn");
         addChild(_indentationBtn);
         _postSprite = new Sprite();
         addChild(_postSprite);
         _postBg = ComponentFactory.Instance.creat("asset.hall.systemPost.bg");
         _postSprite.addChild(_postBg);
         _currItem = new SystemPostItem();
         _postSprite.addChild(_currItem);
      }
      
      private function initEvent() : void
      {
         _postSprite.addEventListener("click",__onMouseClick);
         _indentationBtn.addEventListener("click",__onIndentationClick);
         SystemPostManager.Instance.addEventListener(SystemPostManager.SYSTEMPOST_UPDATE,__onReceivePost);
      }
      
      private function initData() : void
      {
         var obj:Object = SystemPostManager.Instance.postInfo;
         if(obj)
         {
            addListItem(obj.msg,obj.type);
         }
         else
         {
            _indentationBtn.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      protected function __onReceivePost(event:Event) : void
      {
         var obj:Object = SystemPostManager.Instance.postInfo;
         addListItem(obj.msg,obj.type);
         if(_indentationBtn && _indentationBtn.selected)
         {
            _indentationBtn.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function addListItem(msg:String, type:int) : void
      {
         if(_currItem)
         {
            _currItem.update(msg,type);
         }
      }
      
      protected function __onMouseClick(event:MouseEvent) : void
      {
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("setselfplayerpos",[event]));
      }
      
      protected function __onIndentationClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var dur:int = !!_indentationBtn.selected?-1 * _postBg.width:0;
         TweenLite.to(_postSprite,0.5,{"x":dur});
      }
      
      private function removeEvent() : void
      {
         if(_postSprite)
         {
            _postSprite.removeEventListener("click",__onMouseClick);
         }
         if(_indentationBtn)
         {
            _indentationBtn.removeEventListener("click",__onIndentationClick);
         }
         SystemPostManager.Instance.removeEventListener(SystemPostManager.SYSTEMPOST_UPDATE,__onReceivePost);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_indentationBtn);
         _indentationBtn = null;
         ObjectUtils.disposeObject(_postBg);
         _postBg = null;
         ObjectUtils.disposeObject(_currItem);
         _currItem = null;
         ObjectUtils.disposeObject(_postSprite);
         _postSprite = null;
      }
   }
}
