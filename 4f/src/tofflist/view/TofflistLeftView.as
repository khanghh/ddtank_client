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
      
      public function TofflistLeftView(){super();}
      
      public function dispose() : void{}
      
      private function init() : void{}
   }
}
