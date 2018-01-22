package email.view
{
   import ddt.data.email.EmailInfoOfSended;
   import ddt.manager.LanguageMgr;
   
   public class EmailStripSended extends EmailStrip
   {
       
      
      public function EmailStripSended()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _checkBox.visible = false;
         _payImg.visible = false;
         _unReadImg.visible = false;
         _emailType.visible = false;
      }
      
      override public function update() : void
      {
         _topicTxt.text = _info.Title;
         if(_info.Type == 59)
         {
            _senderTxt.text = LanguageMgr.GetTranslation("tank.view.emailII.EmailIIStripSended.sender_txtMember");
         }
         else
         {
            _senderTxt.text = LanguageMgr.GetTranslation("tank.view.emailII.EmailIIStripSended.sender_txt") + (_info as EmailInfoOfSended).Receiver;
         }
         if(_isReading)
         {
            _emailStripBg.bg.gotoAndStop(2);
         }
         else
         {
            _emailStripBg.bg.gotoAndStop(1);
         }
         _cell.centerMC.visible = true;
         _cell.centerMC.setFrame(5);
      }
   }
}
