package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class TofflistLeftView extends Sprite implements Disposeable
   {
       
      
      private var _chatFrame:Sprite;
      
      private var _currentPlayer:TofflistLeftCurrentCharcter;
      
      private var _bg1:MovieClip;
      
      private var _bg2:Bitmap;
      
      private var _lightsMc:MovieClip;
      
      public function TofflistLeftView()
      {
         super();
         init();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _currentPlayer = null;
         if(_bg1)
         {
            ObjectUtils.disposeObject(_bg1);
         }
         if(_bg2)
         {
            ObjectUtils.disposeObject(_bg2);
         }
         if(_lightsMc)
         {
            ObjectUtils.disposeObject(_lightsMc);
         }
         if(_chatFrame)
         {
            ObjectUtils.disposeObject(_chatFrame);
         }
         _bg1 = null;
         _bg2 = null;
         _lightsMc = null;
         _chatFrame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function init() : void
      {
         _bg1 = ComponentFactory.Instance.creat("asset.background.tofflist.left");
         addChild(_bg1);
         _bg2 = ComponentFactory.Instance.creatBitmap("toffilist.leftImgBg");
         addChild(_bg2);
         _currentPlayer = new TofflistLeftCurrentCharcter();
         addChild(_currentPlayer);
         _lightsMc = ComponentFactory.Instance.creat("asset.LightsMcAsset");
         _lightsMc.x = 6;
         _lightsMc.y = 14;
         addChild(_lightsMc);
         ChatManager.Instance.state = 15;
         _chatFrame = ChatManager.Instance.view;
         addChild(_chatFrame);
      }
   }
}
