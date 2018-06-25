package ddt.view.im
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.SharedManager;
   import ddt.utils.PositionUtils;
   
   public class TeamRecordFrame extends PrivateRecordFrame
   {
       
      
      public function TeamRecordFrame()
      {
         super();
         reset();
      }
      
      private function reset() : void
      {
         PositionUtils.setPos(_close,"teamChatClosePos");
         _contentBG.height = 330;
         _content.height = 294;
      }
      
      public function set teamId(id:int) : void
      {
         if(SharedManager.Instance.teamChatRecord[id])
         {
            _messages = SharedManager.Instance.teamChatRecord[id];
         }
         else
         {
            _messages = new Vector.<Object>();
         }
         _totalPage = _messages.length % 20 == 0?_messages.length / 20:Number(int(_messages.length / 20) + 1);
         _totalPage = _totalPage == 0?1:_totalPage;
         _pageWord.text = LanguageMgr.GetTranslation("IM.ChatFrame.recordFrame.pageWord",_totalPage);
         showPage(1);
      }
   }
}
