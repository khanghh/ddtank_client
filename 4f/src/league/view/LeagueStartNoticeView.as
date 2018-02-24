package league.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.geom.Point;
   
   public class LeagueStartNoticeView extends BaseAlerFrame
   {
       
      
      private var _bmpNpc:Bitmap;
      
      private var _bmpTxt:Bitmap;
      
      public function LeagueStartNoticeView(){super();}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function initView() : void{}
      
      override public function dispose() : void{}
      
      public function show() : void{}
   }
}
