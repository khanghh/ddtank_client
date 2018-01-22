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
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(0,0.5);
         _loc1_.graphics.drawRect(0,0,_postBg.width,_postBg.height);
         _loc1_.graphics.endFill();
         _loc1_.x = 0;
         _loc1_.y = this.y;
         addChild(_loc1_);
         _postSprite.mask = _loc1_;
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
         var _loc1_:Object = SystemPostManager.Instance.postInfo;
         if(_loc1_)
         {
            addListItem(_loc1_.msg,_loc1_.type);
         }
         else
         {
            _indentationBtn.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      protected function __onReceivePost(param1:Event) : void
      {
         var _loc2_:Object = SystemPostManager.Instance.postInfo;
         addListItem(_loc2_.msg,_loc2_.type);
         if(_indentationBtn && _indentationBtn.selected)
         {
            _indentationBtn.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function addListItem(param1:String, param2:int) : void
      {
         if(_currItem)
         {
            _currItem.update(param1,param2);
         }
      }
      
      protected function __onMouseClick(param1:MouseEvent) : void
      {
         PlayerManager.Instance.dispatchEvent(new NewHallEvent("setselfplayerpos",[param1]));
      }
      
      protected function __onIndentationClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:int = !!_indentationBtn.selected?-1 * _postBg.width:0;
         TweenLite.to(_postSprite,0.5,{"x":_loc2_});
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
