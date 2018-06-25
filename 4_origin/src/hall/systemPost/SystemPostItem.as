package hall.systemPost
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import redPackage.RedPackageManager;
   
   public class SystemPostItem extends Sprite implements Disposeable
   {
       
      
      private var _speaker:Bitmap;
      
      private var _postText:FilterFrameText;
      
      private var _postHtmlText:FilterFrameText;
      
      private var _type:int;
      
      public function SystemPostItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _speaker = ComponentFactory.Instance.creat("asset.hall.systemPost.speaker");
         addChild(_speaker);
         _postHtmlText = ComponentFactory.Instance.creatComponentByStylename("hall.systemPost.postInfoTxt");
         addChild(_postHtmlText);
         _postText = ComponentFactory.Instance.creatComponentByStylename("hall.systemPost.postInfoTxt");
         addChild(_postText);
         _postHtmlText.mouseEnabled = true;
      }
      
      public function update(msg:String, type:int) : void
      {
         var _loc3_:String = "";
         _postText.text = _loc3_;
         _postHtmlText.htmlText = _loc3_;
         _type = type;
         if(_type > 0)
         {
            if(_type == 4)
            {
               _postHtmlText.htmlText = msg;
            }
            else
            {
               _postHtmlText.htmlText = "<a href=\"event:1\"><u>" + msg + "</u></a>";
            }
            _postHtmlText.addEventListener("link",__onTextLink);
         }
         else
         {
            _postText.text = msg;
         }
      }
      
      protected function __onTextLink(event:TextEvent) : void
      {
         if(_type == 1)
         {
            RedPackageManager.getInstance().showView("red_pkg_consortia_gain");
         }
         else
         {
            navigateToURL(new URLRequest(event.text));
         }
      }
      
      private function removeEvent() : void
      {
         _postHtmlText.removeEventListener("link",__onTextLink);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_speaker);
         _speaker = null;
         ObjectUtils.disposeObject(_postHtmlText);
         _postHtmlText = null;
         ObjectUtils.disposeObject(_postText);
         _postText = null;
      }
   }
}
