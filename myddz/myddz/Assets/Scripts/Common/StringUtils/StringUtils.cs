using UnityEngine;
using System.Collections;
using System.Text.RegularExpressions;

namespace Common
{
    /// <summary>
    /// 字符串类
    /// </summary>
    public class StringUtils
    {
        /// <summary>
        /// 校验昵称是否合法
        /// </summary>
        /// <param name="strNickName"></param>
        /// <returns></returns>
        public static string CheckNickName(string strNickName)
        {
            if (strNickName=="")
            {
                return "昵称不能为空";
            }
            int len = System.Text.Encoding.Default.GetBytes(strNickName).Length;
            if (len < 4)
            {
                return "昵称不能少于四位";

            }
            else if (len>12)
            {
                return "昵称不能超过12位";
            }
            if (!Regex.IsMatch(strNickName, "^[\u4e00-\u9fa5a-zA-Z0-9]+$"))
            {
                return "昵称不合法";
            }
            if (Regex.IsMatch(strNickName, @"^[0-9]*$"))
            {
                return "昵称不能为纯数字";
            }
           
            return "";
           
        }
        /// <summary>
        /// 检验身份证号是否合法
        /// </summary>
        /// <param name="idcard">传入参数</param>
        /// <returns></returns>
        public static string CheckIDcard(string idcard)
        {
            if (!Regex.IsMatch(idcard, @"(^\d{18}$)|(^\d{15}$)"))
            {
                return "请输入正确的身份证号";
            }
            if (idcard=="")
            {
                return "身份证号不能为空";
            }
            return "";
        }
        /// <summary>
        /// 验证手机号码是否合法
        /// </summary>
        /// <param name="phoneId"></param>
        /// <returns></returns>
        public static string CheckTelephone(string phoneId)
        {

            if (phoneId=="")
            {
                return "手机号不能为空";

            }
            if (!Regex.IsMatch(phoneId, @"^[1]+[3,5]+\d{9}"))
            {
                return "请输入合法的手机号码";
            }
            return "";
        }
        /// <summary>
        /// 验证邮编是否合法
        /// </summary>
        /// <param name="PostalCode"></param>
        /// <returns></returns>
        public static string CheckPostalCode(string PostalCode)
        {
            if (PostalCode=="")
            {
                return "邮编不能为空";
            }
            if (!Regex.IsMatch(PostalCode, @"^\d{6}$"))
            {
                return "请输入正确的邮编";
            }
            return "";
        }
        public static string CheckEamil(string strEamil)
        {
            if (strEamil=="")
            {
                return "邮箱不能为空";
            }
            if (!Regex.IsMatch(strEamil, @"\\w{1,}@\\w{1,}\\.\\w{1,}"))
            {
                return "请输入正确的邮箱";
            }
            return "";
        }

    }
}

 