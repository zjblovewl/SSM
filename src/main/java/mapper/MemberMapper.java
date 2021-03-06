package mapper;

import entity.Member;
import entity.MemberExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface MemberMapper {
    int countByExample(MemberExample example);
    int countByMember(Member member);

    int deleteByExample(MemberExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Member record);

    Member selectByNumber(String Number);

    int insertSelective(Member record);

    List<Member> selectByExample(MemberExample example);

    List<Member> selectBy(Member member);

    List<Member> selectByLike(Map<String,Object> map);

    Member selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Member record, @Param("example") MemberExample example);

    int updateByExample(@Param("record") Member record, @Param("example") MemberExample example);

    int updateByPrimaryKeySelective(Member record);

    int updateByPrimaryKey(Member record);
}