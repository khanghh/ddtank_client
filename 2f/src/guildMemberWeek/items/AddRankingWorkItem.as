package guildMemberWeek.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   
   public class AddRankingWorkItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _RankingBitmp:ScaleFrameImage;
      
      private var _RankingText:FilterFrameText;
      
      private var _AddPointBookText:FilterFrameText;
      
      private var _GetPointBookText:FilterFrameText;
      
      private var _inputTxt:FilterFrameText;
      
      private var _ShowGetPointBookText:FilterFrameText;
      
      private var _PointBookBitmp:Bitmap;
      
      private var _ItemID:int = 0;
      
      public function AddRankingWorkItem(){super();}
      
      public function get AddMoney() : int{return 0;}
      
      public function initView(param1:int) : void{}
      
      public function initText() : void{}
      
      public function initEvent() : void{}
      
      private function RemoveEvent() : void{}
      
      private function __ItemWorkCheckKeyboard(param1:KeyboardEvent) : void{}
      
      private function __ItemWorkFocusEvent(param1:FocusEvent) : void{}
      
      private function _ItemWork() : void{}
      
      public function ChangeGetPointBook(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
