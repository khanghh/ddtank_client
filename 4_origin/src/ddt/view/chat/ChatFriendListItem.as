package ddt.view.chat
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ChatFriendListItem extends Sprite implements IListCell, Disposeable
   {
      
      public static const SELECT:String = "select";
       
      
      private var _bg:Bitmap;
      
      private var _contentTxt:TextField;
      
      private var _fun:Function;
      
      private var _info:BasePlayer;
      
      private var _spaceLine:Bitmap;
      
      public function ChatFriendListItem()
      {
         super();
         init();
         initEvent();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_spaceLine);
         _spaceLine = null;
         if(_contentTxt && _contentTxt.parent)
         {
            _contentTxt.parent.removeChild(_contentTxt);
            _contentTxt = null;
         }
         _info = null;
         _fun = null;
         removeEventListener("mouseOver",__mouseOver);
         removeEventListener("mouseOut",__mouseOut);
      }
      
      public function get info() : BasePlayer
      {
         return _info;
      }
      
      private function __mouseClick(evt:MouseEvent) : void
      {
         if(_fun != null)
         {
            SoundManager.instance.play("008");
            _fun(_info.NickName,_info.ID);
         }
      }
      
      private function __mouseOut(evt:MouseEvent) : void
      {
         _bg.alpha = 0;
      }
      
      private function __mouseOver(evt:MouseEvent) : void
      {
         _bg.alpha = 1;
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.core.comboxItembg3");
         _bg.width = 140;
         _spaceLine = ComponentFactory.Instance.creat("asset.chat.FriendListItemSpaceLine");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("chat.FriendList.ItemTxt");
         _contentTxt.mouseEnabled = false;
         addChild(_bg);
         addChild(_spaceLine);
         addChild(_contentTxt);
         _bg.alpha = 0;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__mouseOver);
         addEventListener("mouseOut",__mouseOut);
      }
      
      private function updateItem() : void
      {
         _contentTxt.text = _info.NickName;
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(value:*) : void
      {
         _info = value;
         updateItem();
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
