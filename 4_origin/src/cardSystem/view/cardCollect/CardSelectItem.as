package cardSystem.view.cardCollect
{
   import cardSystem.CardSocketEvent;
   import cardSystem.data.SetsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CardSelectItem extends Sprite implements Disposeable
   {
       
      
      private var _nameTxt:FilterFrameText;
      
      private var _bgImg:Bitmap;
      
      private var _id:String;
      
      public function CardSelectItem()
      {
         super();
         init();
         initEvents();
      }
      
      private function init() : void
      {
         _bgImg = ComponentFactory.Instance.creat("asset.chat.FriendListItemBg2");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("cardSystem.CardNameTxt");
         addChild(_nameTxt);
         addChildAt(_bgImg,0);
         _bgImg.alpha = 0;
         _bgImg.width = 100;
         _bgImg.y = -2;
      }
      
      private function initEvents() : void
      {
         addEventListener("click",__click);
         addEventListener("mouseOver",__mouseOver);
         addEventListener("mouseOut",__mouseOut);
      }
      
      private function __mouseOver(event:MouseEvent) : void
      {
         _bgImg.alpha = 1;
      }
      
      private function __mouseOut(event:MouseEvent) : void
      {
         _bgImg.alpha = 0;
      }
      
      private function __click(e:MouseEvent) : void
      {
         var obj:Object = {};
         obj.id = _id;
         var evt:CardSocketEvent = new CardSocketEvent("select_cards",obj);
         dispatchEvent(evt);
      }
      
      public function set info(goods:SetsInfo) : void
      {
         _nameTxt.text = goods.name;
         _id = goods.ID;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bgImg);
         _bgImg = null;
         if(_nameTxt && _nameTxt.parent)
         {
            _nameTxt.parent.removeChild(_nameTxt);
            _nameTxt = null;
         }
         removeEventListener("click",__click);
         removeEventListener("mouseOver",__mouseOver);
         removeEventListener("mouseOut",__mouseOut);
      }
   }
}
